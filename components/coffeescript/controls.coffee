DOM = require('./dom')
Query = require('./query')
Drawing = require('./drawing')

CountryCodes = require('./countryCodes')

GLOBALS =
    eventCount: 5
    fromMoment: moment()
    toMoment: moment()
    startEvent: ''
    endEvent: ''
    superPropertyOptions: ''
    propertyFilters:
        global: null
        startEvent: null

# Getters/Setters for global varibles
getEventCount = ->
    GLOBALS.eventCount

setEventCount = (eventCount) ->
    GLOBALS.eventCount = eventCount
    return

getFromMoment = ->
    GLOBALS.fromMoment

setFromMoment = (fromMoment) ->
    GLOBALS.fromMoment = fromMoment
    return

getToMoment = ->
    GLOBALS.toMoment

setToMoment = (toMoment) ->
    GLOBALS.toMoment = toMoment
    return

getStartEvent = ->
    GLOBALS.startEvent

setStartEvent = (startEvent) ->
    GLOBALS.startEvent = startEvent
    return

getEndEvent = ->
    GLOBALS.endEvent

setEndEvent = (endEvent) ->
    GLOBALS.endEvent = endEvent
    return

getSuperPropertyOptions = ->
    GLOBALS.superPropertyOptions

setSuperPropertyOptions = (superPropertyOptions) ->
    GLOBALS.superPropertyOptions = superPropertyOptions
    return

getStartEventPropertyFilter = ->
    GLOBALS.propertyFilters.startEvent

setStartEventPropertyFilter = (startEventPropertyFilter) ->
    GLOBALS.propertyFilters.startEvent = startEventPropertyFilter
    return

getGlobalPropertyFilter = ->
    GLOBALS.propertyFilters.global

setGlobalPropertyFilter = (globalPropertyFilter) ->
    GLOBALS.propertyFilters.global = globalPropertyFilter
    return

getPropertyFilters = ->
    GLOBALS.propertyFilters

# Setters for controls

initReport = ->
    DOM.addLoadingSymbol() # Add loading symbol to the DOM
    # Set event select and 
    setEventValuesForSelect $('#start-event-select'), '--CHOOSE A START EVENT--'
    initDatePicker()
    # Init super property select
    initSuperPropertySelect()
    # Create all handlers as well
    indicatorHandler()
    eventSelectHandler()
    propertySelectHandler()
    propertyValueSelectHandler()
    superPropertySelectHandler()
    globalFilterButtonHandler()
    datePickerHandler()
    return

setEventValuesForSelect = ($select, title) ->
    $select.MPSelect()
    MP.api.topEvents().done (results) ->
        # Get options for MPSelect
        options = _.chain results.values()
            .map (eventName) ->
                {
                    label: if eventName.charAt(0) == '$' then eventName else eventName.toUpperCase()
                    value: eventName
                }
            .value()
        # Add 'ghost' option
        options.unshift { label: title, value: '' }
        # Set options for MPSelect
        options = items: options
        $select.MPSelect 'initEl', options
    return

setPropertyValuesForSelect = ($select, event, property) ->
    params =
        limit: 10000
    $select.MPSelect()
    MP.api.propertyValues(event, property, params).done (results) ->
        # only capitalize options that aren't emails, websites, social media handles
        options = _.chain results.values()
            .sortBy (option) ->
                if Number option
                    option = Number option
                option
            .map (option) ->
                {
                    label: if option.indexOf('@') < 0 and option.indexOf('http:') < 0 then option.toUpperCase() else option
                    value: option
                }
            .value()
        options.unshift { label: '--SELECT A VALUE--', value: '' }
        options = items: options
        $select.MPSelect 'initEl', options
        return
    return

setSuperPropertyValuesForSelect = ($select, property) ->
    params =
        name: property
        limit: 10000
    $select.MPSelect()
    MP.api.query '/api/2.0/events/properties/values', params, null, (data) ->
        data = JSON.parse data
        # only capitalize options that aren't emails, websites, social media handles
        options = _.chain data
            .map (option) ->
                {
                    label: transformPropertyValueLabel property, option
                    value: option
                }
            .sortBy (option) ->
                if Number option.label
                    option = Number option.label
                option.label
            .value()
        options.unshift { label: '--SELECT A VALUE--', value: '' }
        options = items: options
        $select.MPSelect 'initEl', options
    return

initDatePicker = ->
    # Initialize date picker and define handler for when date range changes
    $datePicker = $('#date-picker').MPDatepicker()
    # Set date picker to today
    $datePicker.val
        from: getFromMoment().toDate()
        to: getToMoment().toDate()
    # Style the date picker
    $datePickerEl = $datePicker.find '.mixpanel-platform-date_picker'
    $datePickerEl.addClass 'mp-date-picker'
    return

initSuperPropertySelect = ->
    $superPropertySelect = $('.mp-super-property-select').MPSelect()
    params =
        type: 'general'
        limit: 10000
    MP.api.query '/api/2.0/events/properties/toptypes', params, null, (data) ->
        data = JSON.parse data
        # only capitalize options that aren't default properties
        options = _.chain data
            .keys()
            .map (property) ->
                {
                    label: transformPropertyLabel property
                    value: property
                }
            .sortBy (property) -> property.label
            .value()
        # Add 'ghost' option
        options.unshift { label: '--SELECT A PROPERTY--', value: '' }
        options = items: options
        $superPropertySelect.MPSelect 'initEl', options
        # Cache options for later
        setSuperPropertyOptions options
        return
    return

transformPropertyLabel = (property) ->
    if property.charAt(0) == '$'
        property = property.slice 1
    property = property.replace /(^mp_|_)/g, ' '
    property = property.trim()
    property.toUpperCase()

transformPropertyValueLabel = (property, value) ->
    if property == 'mp_country_code'
       value = CountryCodes.getCountryForCountryCode value
    if value.indexOf('@') < 0 and value.indexOf('http:') < 0
        value = value.toUpperCase()
    value

# Handlers for controls

eventSelectHandler = ->
    $('body').on 'change', '.mp-event-select', (e, selectedEvent) ->
        id = $(@).attr 'id'
        $parent = $(@).parent()
        # Look for an indicator
        $indicator = $parent.find '.mp-indicator'
        # Determine if we need to refresh and set start event / end events appropriately
        if id == 'start-event-select'
            if getStartEvent() == selectedEvent
                # Nothing to do here
                return
            setStartEvent selectedEvent
            # Reset start event property filter
            setStartEventPropertyFilter null
        if id == 'end-event-select'
            if getEndEvent() == selectedEvent
                # Nothing to do here
                return
            setEndEvent selectedEvent
            # $$RG$$ TODO: reset end event property filter (when it exists)
        # Now perform some state logic based on presence of indicator
        if $indicator.length
            $propertySelect = $parent.find '.mp-property-select'
            $filterControlsGroup = $parent.find '.filter-controls-group'
            # Reset indicator to expand
            DOM.contractIndicator $indicator
            # Remove property select and filter controls group if either exist
            $propertySelect.remove() if $propertySelect.length
            $filterControlsGroup.remove() if $filterControlsGroup.length
        else
            # Create indicator and add to the DOM
            $indicator = DOM.createIndicator()
            $(@).after $indicator
        # Get results
        getResults getFromMoment(), getToMoment(), getEventCount(), getStartEvent(), getEndEvent(), getPropertyFilters()
        return

globalFilterButtonHandler = ->
    $containerOptionsGlobalFilter = $('.container-options-global-filter')
    $('.global-filter-button').on 'click', (e) ->
        $thisButton = $(@)
        # Toggle inactive classes for this button as well as the container for global controls
        $thisButton.toggleClass 'inactive'
        $containerOptionsGlobalFilter.toggleClass 'inactive'
        $thisButton.addClass 'button-click'
        $globalFilterText = $thisButton.find '.global-filter-text'
        # Determine which text should be shown on the button
        if $thisButton.hasClass 'inactive'
            $globalFilterText.text 'APPLY GLOBAL FILTER TO PATHS'
        else
            $globalFilterText.text 'REMOVE GLOBAL FILTER'
        # Wait for animations to end before highlighting button on hover
        $containerOptionsGlobalFilter.one 'webkitTransitionEnd otransitionend msTransitionEnd transitionend', (e) ->
            # Collapse global filter if necessary or reset the select if there's no indicator
            $indicator = $(@).find '.mp-indicator'
            # Reset super property filters
            if $indicator.length
                $indicator.click()
            $thisButton.removeClass 'button-click'
            return
        return
    return

indicatorHandler = ->
    $('body').on 'click', '.mp-indicator', (e) ->
        $parent = $(@).parent()
        $propertySelect = $parent.find '.mp-property-select'
        $eventSelect = $parent.find '.mp-event-select'
        $filterControlsGroup = $parent.find '.filter-controls-group'
        if $(@).hasClass 'expand'
            # We're ready to expand the row
            DOM.expandIndicator $(@)
            # Create and initialize the property select
            $propertySelect = DOM.createPropertySelectWithID '#start-event-property-select'
            $propertySelect.MPPropertySelect 'setEvent', getStartEvent()
            # Add the property select to the DOM
            $(@).before $propertySelect
        else if $(@).hasClass 'contract'
            $superPropertySelect = $parent.find '.mp-super-property-select'
            fromStartEvent = $(@).parent().attr('class').indexOf('start-event') > 0
            fromGlobal = $(@).parent().attr('class').indexOf('global-filter') > 0
            # We're currently expanded, so remove all filter controls if they exist
            DOM.contractIndicator $(@)
            $propertySelect.remove() if $propertySelect.length
            $filterControlsGroup.remove() if $filterControlsGroup.length
            # Check if we have a super property select
            if $superPropertySelect.length
                # Reset select
                $superPropertySelect.MPSelect() # Safeguard for uninitialized property select
                $superPropertySelect.MPSelect 'initEl', getSuperPropertyOptions()
                # Remove indicator
                $(@).remove()
            if fromStartEvent
                # Clear start event filter
                setStartEventPropertyFilter null
            else if fromGlobal
                # Clear global event filter
                setGlobalPropertyFilter null
            # Update results based on removing the start event or global filter
            getResults getFromMoment(), getToMoment(), getEventCount(), getStartEvent(), getEndEvent(), getPropertyFilters()
        return
    return

propertySelectHandler = ->
    $('body').on 'change', '.mp-property-select', (e, selectedProperty) ->
        $parent = $(@).parent()
        $filterControlsGroup = $parent.find '.filter-controls-group'
        $indicator = $parent.find '.mp-indicator'
        if !$filterControlsGroup.length
            # Create the filter controls group if it doesn't exist
            $filterControlsGroup = DOM.createFilterControlsGroup()
            $indicator.before $filterControlsGroup
            # Need to instantiate a new property value select
        $propertyValueSelect = $filterControlsGroup.find '.mp-property-value-select'
        # We should now have a property value select, so populate the select
        if $propertyValueSelect.length
            setPropertyValuesForSelect $propertyValueSelect, getStartEvent(), selectedProperty
        return
    return

superPropertySelectHandler = ->
    $('body').on 'change', '.mp-super-property-select', (e, selectedProperty) ->
        $parent = $(@).parent()
        $filterControlsGroup = $parent.find '.filter-controls-group'
        if !$filterControlsGroup.length
            # Create the filter controls group if it doesn't exist
            $filterControlsGroup = DOM.createFilterControlsGroup()
            # Add to the DOM
            $(@).after $filterControlsGroup
            # Create an expanded indicator and add at the end of the DOM
            $indicator = DOM.createIndicator()
            DOM.expandIndicator $indicator
            $parent.append $indicator
        $propertyValueSelect = $filterControlsGroup.find '.mp-property-value-select'
        # We should now have a property value select, so populate the select
        if $propertyValueSelect.length
            setSuperPropertyValuesForSelect $propertyValueSelect, selectedProperty
        return
    return

propertyValueSelectHandler = ->
    $('body').on 'change', '.mp-property-value-select', (e, selectedValue) ->
        # $$RG$$ TODO: this is where we run the query
        # Go up two parents to figure out if 
        $parent = $(@).parent().parent()
        fromStartEvent = $parent.attr('class').indexOf('start-event') > 0
        fromGlobal = $parent.attr('class').indexOf('global-filter') > 0
        if fromStartEvent
            # TODO: put in helper function
            # Get appropriate fields + values
            $eventSelect = $parent.find '.mp-event-select'
            $propertySelect = $parent.find '.mp-property-select'
            event = $eventSelect.val()
            property = $propertySelect.val()
            operator = 'equals'
            value = $(@).val()
            filter =
                property: property
                operator: operator
                value: value
            if !_.isEqual filter, getStartEventPropertyFilter()
                setStartEventPropertyFilter filter
                # Update results based on the start event property filter
                getResults getFromMoment(), getToMoment(), getEventCount(), getStartEvent(), getEndEvent(), getPropertyFilters()
            # Re-run if necessary
        else if fromGlobal
            # TODO: put in helper function
            $propertySelect = $parent.parent().find '.mp-super-property-select'
            property = $propertySelect.val()
            operator = 'equals'
            value = $(@).val()
            filter =
                property: property
                operator: operator
                value: value
            if !_.isEqual filter, getGlobalPropertyFilter()
                setGlobalPropertyFilter filter
                # Update results based on the global property filter
                getResults getFromMoment(), getToMoment(), getEventCount(), getStartEvent(), getEndEvent(), getPropertyFilters()
        return
    return

datePickerHandler = ->
    $('#date-picker').on 'change', (e, dateRange) ->
        fromMoment = moment dateRange.from
        toMoment = moment dateRange.to
        # Only update report if the date has changed
        if not getFromMoment().isSame(fromMoment) or not getToMoment().isSame(toMoment)
            setFromMoment fromMoment
            setToMoment toMoment
            getResults getFromMoment(), getToMoment(), getEventCount(), getStartEvent(), getEndEvent(), getPropertyFilters()
        return
    return

# Gets results for the report
getResults = (from, to, eventCount, startEvent, endEvent, propertyFilters) ->
    # Do nothing if the start event or end event has not been set
    if _.isEmpty(startEvent) and _.isEmpty(endEvent)
        return
    # Only show loading symbol
    DOM.showLoadingSymbol()
    # Destroy any existing reports
    Drawing.destroyReport()
    # Get response and show results
    Query.getFlowsResponse from, to, eventCount, startEvent, endEvent, propertyFilters
    .then (results) ->
        # Hide loading and show new results
        DOM.hideLoadingSymbol()
        Drawing.createFlowsReport results
    .catch (error) ->
        console.log 'Failed with following error:', error
    return

module.exports =
    initReport: initReport
