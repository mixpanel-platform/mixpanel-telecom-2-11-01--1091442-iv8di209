function nodeSort(obj){
  return Object.keys(obj).sort(function(a,b){return obj[b]['value']-obj[a]['value'];});
}

function steps(item) {
        var obj = {};
        for (var i = 0; i < item.length; i++) { // number of flows
            for (var j = 0; j < item[i].length; j++) { // number of events in flow
                obj[j] = obj[j] || {};
                var current = item[i][j];
                var next= item[i][j+1] || "Exit";
                if (next) {
                    var strConcat = current + '~' + next;
                    obj[j][strConcat] = obj[j][strConcat] + 1 || 1;
                }
            }
        }
        return obj;
}
function createState(state, events) {
        state = state || {
            current_sequence: [],
            event_sequences: [],
            in_funnel: false,
            funnel_start: 0
        };
        var i = 0;
        var n = events.length;
       _.each(events, function(event){
          var name
          if (event.name == 'Page View') { 
            name = 'Page View - ' + event.properties['Screen Name'] 
            
          } else if (event.name == 'pageview') { 
            name = 'Page View - ' + event.properties['pagename'] 
          } else {
            name = event.name
          }
          if (event.name == params.start_event) {
            state.in_funnel = true;
            state.funnel_start = event.time;
            if (state.current_sequence.length) {
              state.event_sequences.push(state.current_sequence);
              state.current_sequence = [];
            }
            state.current_sequence.push(event.name);
          } else if (state.in_funnel) {
            if (name == params.end_event) {
                  state.current_sequence.push(name);
                  state.event_sequences.push(state.current_sequence);
                  state.current_sequence = [];
                  state.in_funnel = false;
            } else if (state.current_sequence.length > params.event_count || state.funnel_start + params.session_length < event.time ) {
                state.event_sequences.push(state.current_sequence);
                state.current_sequence = [];
                state.in_funnel = false;
              } else {
                state.current_sequence.push(name);
              }
          }
        });
        return state;
    }

function flows(item){
    var results = [];
    // summation for links
    // top filters for other combo
   // Walk through each step to access each unique Source ~ Target Pair
    _.each(item, function(linkString, step){
      var nodes = {};
      var links = [];
      var otherObj = { value: 0, exit: 0 };
      var otherCount = 0;
      var targets = {};
      var linkObj = {};

    // Walk through each linkstring to split and merge to other objects
      _.each(linkString, function(val, link){
        var split = link.split('~');
        var source = split[0];
        var target = split[1];
        nodes[source] = nodes[source] || { exit: 0, value: 0 };
        targets[target] = targets[target] || { value: 0 };
        linkObj[source] = linkObj[source] || {};
        if (target === 'Exit') {
          nodes[source]['exit'] += val;
        }
        nodes[source]['value'] += val;
        if (target !== 'Exit') {
          targets[target]['value'] += val;
          linkObj[source][target] = val;
        }
      });
      var sortedTargets = nodeSort(targets);
      var otherTargetList = sortedTargets.slice(5);
      var otherTargets = new Set(otherTargetList);
      var sorted = nodeSort(nodes);
      var otherNodes = sorted.slice(5);

      // Modify our source to Other
      // Keep a list of all other SRC all other Trg
      // for each link merge

      _.each(otherNodes, function(name){
          otherObj['value'] += nodes[name]['value'];
          otherObj['exit'] += nodes[name]['exit'];
          linkObj['Other'] = linkObj['Other'] || {};
          _.each(linkObj[name], function(val, target){
            linkObj['Other'][target] = linkObj['Other'][target] + val || val;
          });
          otherCount += 1;
          delete linkObj[name];
          delete nodes[name];
      });

      _.each(linkObj, function(obj, src){
        _.each(obj, function(val, target){
          if (otherTargets.has(target)){
            linkObj[src]['Other'] = linkObj[src]['Other'] + val || val;
            delete linkObj[src][target];
          }
        });
      });

      _.each(linkObj, function(obj, src){
        _.each(obj, function(val, target){
          links.push({source: src, target: target, value: val});
        });
      });

      var nodeList = [];
      _.each(nodes, function(obj, src){
        nodeList.push({name: src, value:obj.value, exit:obj.exit});
      });

      nodeList = nodeList.sort(function(a, b) { return b.value - a.value; });
      if(otherObj['value'] || otherObj['exit']) {
        nodeList.push({name: 'Other', value: otherObj.value, exit:otherObj.exit});
      }
      nodeKeys = nodeList.map(function(item){ return item.name; });
      sortedTargets = sortedTargets.slice(0,5);
      sortedTargets.push('Other');

      _.each(links, function(link){
        link.source = nodeKeys.indexOf(link.source);
        link.target = sortedTargets.indexOf(link.target);
      });

      results.push({
        'otherNodes': otherNodes,
        'nodes' : nodeList,
        'links' : links.sort(function(a, b) { return b.value - a.value; }),
        'other' : otherCount,
      });
    });

    return results;
}
function main() {
    return Events({from_date: params.from_date, to_date: params.to_date})
    .groupByUser(createState)
    .filter(function(item) {
        return item.value.event_sequences.length || item.value.current_sequence.length;
    })
    .map(function(item){
      if (item.value.current_sequence.length > 1){
        item.value.event_sequences.push(item.value.current_sequence);
      }
      return item.value.event_sequences;
    })
    .map(steps)
    .reduce(mixpanel.reducer.object_merge())
    .map(flows);
}
