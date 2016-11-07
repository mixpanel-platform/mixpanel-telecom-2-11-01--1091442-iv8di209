# Create indicator as jquery element
createIndicator = ->
    $('<div class="mp-indicator expand"></div>')

# Create property select as jquery element
createPropertySelectWithID = (id) ->
    $('<div id="' + id + '" class="mp-select mp-property-select"></div>').MPPropertySelect()

# Create filter controls group as jquery element
createFilterControlsGroup = ->
    $('<div class="filter-controls-group"><div class="mp-select-small">EQUALS</div><div class="mp-select mp-property-value-select"></div></div>')

# Expands the indicator allowing for it to be contracted
expandIndicator = ($indicator) ->
    if $indicator.length
        $indicator.addClass 'contract'
        $indicator.removeClass 'expand'
    return

# Contracts the indicator allowing for it to be expanded
contractIndicator = ($indicator) ->
    if $indicator.length
        $indicator.addClass 'expand'
        $indicator.removeClass 'contract'
    return

# Adds loading symbol to DOM and initially hides it
addLoadingSymbol = ->
    loadingSymbol = require('raw!../../images/loading-symbol.svg')
    $flowsChartArea = $('.flows-chart-area')
    $flowsChartArea.append loadingSymbol
    $('#loading-symbol').attr 'class', 'hidden'
    return

# Show loading symbol, hide report
showLoadingSymbol = ->
    $flowsChartArea = $('.flows-chart-area')
    $loadingSymbol = $('#loading-symbol')
    $noResults = $('.banner')
    $noResults.addClass 'hidden'
    $flowsChartArea.addClass 'loading'
    $loadingSymbol.attr 'class', ''
    return

# Hide loading symbol, show report
hideLoadingSymbol = ->
    $flowsChartArea = $('.flows-chart-area')
    $loadingSymbol = $('#loading-symbol')
    $flowsChartArea.removeClass 'loading'
    $loadingSymbol.attr 'class', 'hidden'
    return

module.exports.createIndicator = createIndicator
module.exports.createPropertySelectWithID = createPropertySelectWithID
module.exports.createFilterControlsGroup = createFilterControlsGroup
module.exports.expandIndicator = expandIndicator
module.exports.contractIndicator = contractIndicator
module.exports.addLoadingSymbol = addLoadingSymbol
module.exports.showLoadingSymbol = showLoadingSymbol
module.exports.hideLoadingSymbol = hideLoadingSymbol
