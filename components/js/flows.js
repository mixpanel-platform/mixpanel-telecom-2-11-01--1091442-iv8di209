function nodeSort(obj){
  return Object.keys(obj).sort(function(a,b){return obj[b]['value']-obj[a]['value'];});
}

function steps(flows) {
        var obj = {};
        _.each(flows, function(flow, flowIdx){
          _.each(flow, function(event,eventIdx){
            obj[eventIdx] = obj[eventIdx] || {};
            var current = event;
            var next = flow[eventIdx + 1] || 'Exit';
            obj[eventIdx][current] = obj[eventIdx][current] || {};
            obj[eventIdx][current][next] = obj[eventIdx][current][next]  + 1 || 1;
          });
        });
        return obj;
}

function startEventsFilter(event){
  var startFilter = params.property_filters.start_event
  var startFunnel = false
  if (event.name === params.start_event) {
    if (!startFilter || event.properties[startFilter.property] === startFilter.value ) {
      startFunnel = true
    }
  }
  return startFunnel
}

function globalEventsFilter(event){
  var globalFilter = params.property_filters.global
  var filter = false
  if (!globalFilter || event.properties[globalFilter.property] === globalFilter.value){
    filter = true
  }
  return filter
}


function createState(state, events) {
        state = state || {
            journey: [],
            journeys: [],
            in_journey: false,
            journey_start: 0
        };
       _.each(events, function(event){
          if (globalEventsFilter(event)) {
            var name = _.clone(event.name);            
            if (event.name == 'Page View') { 
              name = 'Page View - ' + _.clone(event.properties['Screen Name']);
            } else if (event.name == 'pageview') { 
              name = 'Page View - ' + _.clone(event.properties['pagename']);
            }
            // If I meet the start events criteria
            // Push my list of current events to my journeys
            // add the new event to my current journey
            if (startEventsFilter(event)) {
              state.in_journey = true;
              state.journey_start = event.time;
              if (state.journey.length > 0) {
                state.journeys.push(_.clone(state.journey));
                state.journey = [];
              }
              state.journey.push(name);
            } else if (state.in_journey) {
              if (name == params.end_event) {
                    state.journey.push(name);
                    state.journeys.push(state.journey);
                    state.journey = [];
                    state.in_journey = false;
              } else if (state.journey.length > params.event_count || state.journey_start + params.session_length < event.time ) {
                  state.journeys.push(state.journey);
                  state.journey = [];
                  state.in_journey = false;
                } else {
                  state.journey.push(name);
                }
            }
          }
        });
        return state;
    }

function flows(steps){
  var results = [];
  _.each(steps, function(sourceObjs, step){
    var nodes = {};
    var links = [];
    var otherObj = { value: 0, exit: 0 };
    var otherCount = 0;
    var targets = {};
    var linkObj = {};
    _.each(sourceObjs, function(targetsObjs, source){
      nodes[source] = nodes[source] || { exit: 0, value: 0 };
      _.each(targetsObjs, function(val, target){
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
      })
    })
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
    .map(function(item){
      if (item.value.journey.length > 0){
        item.value.journeys.push(item.value.journey);
      }
      return item;
    })
    .filter(function(item) {
        return item.value.journeys.length;
    })
    .map(function(item){
      return item.value.journeys;
    })
    .map(steps)
    .reduce(mixpanel.reducer.object_merge())
    .map(flows);
}
