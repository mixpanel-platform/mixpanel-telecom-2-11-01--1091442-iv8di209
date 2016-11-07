GLOBALS =
    script: ''

getFlowsResponse = (from, to, eventCount, startEvent, endEvent, propertyFilters) ->
    if !GLOBALS.script? or GLOBALS.script.length == 0
        script = require('raw!./../js/flows')
        GLOBALS.script = $.trim(script)
    # Extend params to add
    fromString = from.format 'YYYY-MM-DD'
    toString = to.format 'YYYY-MM-DD'
    property_filters =
        start_event: propertyFilters.startEvent
        global: propertyFilters.global
    params =
        'from_date': fromString
        'to_date': toString
        'event_count': eventCount
        'session_length': 86400000
        'start_event': startEvent
        'property_filters': property_filters

    Promise.resolve(MP.api.jql GLOBALS.script, params)

module.exports.getFlowsResponse = getFlowsResponse
