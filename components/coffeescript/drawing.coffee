require('Number.prototype.condensedValue')

OTHER_INDEX = 5
VALID_WEIGHTS = [0, 1, 2, 3, 4]
MAX_POINTS = 6

START_PATHS =
[
    '<svg id="flows-chart-path-0-0-to-1-0"  width="105px" height="185px" viewBox="0 0 105 185" class="flows-chart-path flows-chart-path-stroke-0"><path d="M2.5,182.5 L2.5,12.5 L12.5,2.5 L102.5,2.5"></path></svg>'
    '<svg id="flows-chart-path-0-0-to-1-1"  width="105px" height="105px" viewBox="0 0 100 100" class="flows-chart-path flows-chart-path-stroke-1"><path d="M2.5,102.5 L2.5,12.5 L12.5,2.5 L102.5,2.5"></path></svg>'
    '<svg id="flows-chart-path-0-0-to-1-2"  width="85px" height="43px" viewBox="0 0 85 43" class="flows-chart-path flows-chart-path-stroke-2"><path d="M2.5,40.5 L42.5,40.5 L42.5,12.5 L52.5,2.5 L82.5,2.5"></path></svg>'
    '<svg id="flows-chart-path-0-0-to-1-3"  width="85px" height="43px" viewBox="0 0 85 43" class="flows-chart-path flows-chart-path-stroke-3"><path d="M2.5,2.5 L42.5,2.5 L42.5,29.5 L52.5,40.5 L82.5,40.5"></path></svg>'
    '<svg id="flows-chart-path-0-0-to-1-4"  width="105px" height="105px" viewBox="0 0 105 105" class="flows-chart-path flows-chart-path-stroke-4"><path d="M2.5,2.5 L2.5,92.5 L12.5,102.5 L102.5,102.5"></path></svg>'
    '<svg id="flows-chart-path-0-0-to-1-5"  width="105px" height="185px" viewBox="0 0 105 185" class="flows-chart-path flows-chart-path-stroke-5"><path d="M2.5,2.5 L2.5,172.5 L12.5,182.5 L102.5,182.5"></path></svg>'
]

PATHS =
[
    [
        '<svg id="flows-chart-path-cur-0-to-nxt-0" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-0-to-nxt-1" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,2.5 L7.5,2.5 L17.5,12.5 L17.5,67.5 L27.5,77.5 L132.5,77.5"></path></svg>'
        '<svg id="flows-chart-path-cur-0-to-nxt-2" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,2.5 L7.5,2.5 L17.5,12.5 L17.5,142.5 L27.5,152.5 L132.5,152.5"></path></svg>'
        '<svg id="flows-chart-path-cur-0-to-nxt-3" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,2.5 L7.5,2.5 L17.5,12.5 L17.5,217.5 L27.5,227.5 L132.5,227.5"></path></svg>'
        '<svg id="flows-chart-path-cur-0-to-nxt-4" width="135px" height="305px" viewBox="0 0 135 305" class="flows-chart-path"><path d="M2.5,2.5 L7.5,2.5 L17.5,12.5 L17.5,292.5 L27.5,302.5 L132.5,302.5"></path></svg>'
        '<svg id="flows-chart-path-cur-0-to-nxt-5" width="135px" height="380px" viewBox="0 0 135 380" class="flows-chart-path"><path d="M2.5,2.5 L7.5,2.5 L17.5,12.5 L17.5,367.5 L27.5,377.5 L132.5,377.5"></path></svg>'
    ]
    [
        '<svg id="flows-chart-path-cur-1-to-nxt-0" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,77.5 L27.5,77.5 L37.5,67.5 L37.5,12.5 L47.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-1-to-nxt-1" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-1-to-nxt-2" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,2.5 L27.5,2.5 L37.5,12.5 L37.5,67.5 L47.5,77.5 L132.5,77.5"></path></svg>'
        '<svg id="flows-chart-path-cur-1-to-nxt-3" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,2.5 L27.5,2.5 L37.5,12.5 L37.5,142.5 L47.5,152.5 L132.5,152.5"></path></svg>'
        '<svg id="flows-chart-path-cur-1-to-nxt-4" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,2.5 L27.5,2.5 L37.5,12.5 L37.5,217.5 L47.5,227.5 L132.5,227.5"></path></svg>'
        '<svg id="flows-chart-path-cur-1-to-nxt-5" width="135px" height="305px" viewBox="0 0 135 305" class="flows-chart-path"><path d="M2.5,2.5 L27.5,2.5 L37.5,12.5 L37.5,292.5 L47.5,302.5 L132.5,302.5"></path></svg>'
    ]
    [
        '<svg id="flows-chart-path-cur-2-to-nxt-0" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,152.5 L47.5,152.5 L57.5,142.5 L57.5,12.5 L67.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-2-to-nxt-1" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,77.5 L47.5,77.5 L57.4958173,67.5 L57.4958173,12.5 L67.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-2-to-nxt-2" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-2-to-nxt-3" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,2.5 L47.5,2.5 L57.5,12.5 L57.5,67.5 L67.5,77.5 L132.5,77.5"></path></svg>'
        '<svg id="flows-chart-path-cur-2-to-nxt-4" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,2.5 L47.5,2.5 L57.5,12.5 L57.5,142.5 L67.5,152.5 L132.5,152.5"></path></svg>'
        '<svg id="flows-chart-path-cur-2-to-nxt-5" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,2.5 L47.5,2.5 L57.5,12.5 L57.5,217.5 L67.5,227.5 L132.5,227.5"></path></svg>'
    ]
    [
        '<svg id="flows-chart-path-cur-3-to-nxt-0" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,227.5 L67.5,227.5 L77.5,217.5 L77.5,12.5 L87.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-3-to-nxt-1" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,152.5 L67.5,152.5 L77.5,142.5 L77.5,12.5 L87.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-3-to-nxt-2" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,77.5 L67.5,77.5 L77.5,67.5 L77.5,12.5 L87.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-3-to-nxt-3" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-3-to-nxt-4" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,2.5 L67.5,2.5 L77.5,12.5 L77.5,67.5 L87.5,77.5 L132.5,77.5"></path></svg>'
        '<svg id="flows-chart-path-cur-3-to-nxt-5" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,2.5 L67.5,2.5 L77.5,12.5 L77.5,142.5 L87.5,152.5 L132.5,152.5"></path></svg>'
    ]
    [
        '<svg id="flows-chart-path-cur-4-to-nxt-0" width="135px" height="305px" viewBox="0 0 135 305" class="flows-chart-path"><path d="M2.5,302.5 L87.5,302.5 L97.5,292.5 L97.5,12.5 L107.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-4-to-nxt-1" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,227.5 L87.5,227.5 L97.5,217.5 L97.5,12.5 L107.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-4-to-nxt-2" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,152.5 L87.5,152.5 L97.5,142.5 L97.5,12.5 L107.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-4-to-nxt-3" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,77.5 L87.5,77.5 L97.5,67.5 L97.5,12.5 L107.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-4-to-nxt-4" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-4-to-nxt-5" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,2.5 L87.5,2.5 L97.5,12.5 L97.5,67.5 L107.5,77.5 L132.5,77.5"></path></svg>'
    ]
    [
        '<svg id="flows-chart-path-cur-5-to-nxt-0" width="135px" height="380px" viewBox="0 0 135 380" class="flows-chart-path"><path d="M2.5,377.5 L107.5,377.5 L117.5,367.5 L117.5,12.5 L127.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-5-to-nxt-1" width="135px" height="305px" viewBox="0 0 135 305" class="flows-chart-path"><path d="M2.5,302.5 L107.5,302.5 L117.5,292.5 L117.5,12.5 L127.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-5-to-nxt-2" width="135px" height="230px" viewBox="0 0 135 230" class="flows-chart-path"><path d="M2.5,227.5 L107.5,227.5 L117.5,217.5 L117.5,12.5 L127.5,2.5 L131.320377,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-5-to-nxt-3" width="135px" height="155px" viewBox="0 0 135 155" class="flows-chart-path"><path d="M2.5,152.5 L107.5,152.5 L117.5,142.5 L117.5,12.5 L127.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-5-to-nxt-4" width="135px" height="80px" viewBox="0 0 135 80" class="flows-chart-path"><path d="M2.5,77.5 L107.5,77.5 L117.5,67.5 L117.5,12.5 L127.5,2.5 L132.5,2.5"></path></svg>'
        '<svg id="flows-chart-path-cur-5-to-nxt-5" width="135px" height="5px" viewBox="0 0 135 5" class="flows-chart-path"><path d="M2.5,2.5 L132.5,2.5"></path></svg>'
    ]
]

getRange = (num1, num2, totalSteps) ->
    range = []
    ascending = num1 < num2
    difference = if ascending then num2 - num1 else num1 - num2
    factor = Math.floor difference / totalSteps
    step = 0
    runner = if ascending then num1 else num2
    while step < totalSteps
        if ascending
            range.push runner
        else
            range.unshift runner
        runner += factor
        ++step
    range
    
createPoint = (name, eventCount, exitCount, endPoint) ->
    point = '<a id="flows-chart-point-n-n" class="flows-chart-point"><div class="flows-chart-point-contents flows-chart-point-effect"><svg viewBox="0 0 32 32" class="flows-chart-point-drop-off"><circle style="stroke-dasharray: 50, 100;" r="16" cx="16" cy="16" class="flows-chart-point-drop-off-percentage"></circle></svg><div class="flows-chart-point-count">141M</div><div class="flows-chart-point-name">APP OPEN</div></div></a>'
    $pointContainer = $('<div/>').html point
    name = name.toUpperCase() if name.charAt(0) != '$'
    $pointContainer.find('div.flows-chart-point-name').text name
    $pointContainer.find('div.flows-chart-point-count').text eventCount.condensedValue()
    $pointContainer.find('a.flows-chart-point').addClass 'flows-chart-end-point' if endPoint
    percentage = exitCount / eventCount * 100
    percentage = Math.floor percentage if percentage >= 1
    percentage = 1 if percentage > 0 and percentage < 1
    $pointContainer.find('svg.flows-chart-point-drop-off circle').css 'stroke-dasharray', percentage + ' 100'
    # add click handler
    $actualPoint = $pointContainer.find('.flows-chart-point')
    $pointContainer.html()

placePoint = (point, row, col) ->
    maxPoint = col == (MAX_POINTS - 1)
    $point = $('<div/>').html point
    if col == 0
        position =
            'top': 225 + 'px'
            'left': 15 + 'px'
    else if col == 1
        position =
            'top': 25 + 80 * row + 'px'
            'left': 135 + 'px'
    else
        position =
            'top': 25 + 80 * row + 'px'
            'left': 135 + (col - 1) * 160 + 'px'
    $point.find('.flows-chart-point').attr 'id', 'flows-chart-point-' + col + '-' + row
    $point.find('.flows-chart-point').addClass 'flows-chart-max-point' if maxPoint
    $point.find('.flows-chart-point').css position
    $point.html()

createStartPaths = (pathCount = 6) ->
    paths = ''
    index = 0
    while index < pathCount
        paths += START_PATHS[index++]
    paths
        
createPath = (col, currentRow, nextRow, weight) ->
    path = PATHS[currentRow][nextRow]
    $path = $('<div\>').html path
    position =
        left: 175 + 160 * (col - 1) + 'px'
        top: '0px'
    strokeValue = weight
    strokeValue = OTHER_INDEX if currentRow == OTHER_INDEX
    if currentRow <= nextRow
        position.top = 35 + nextRow * 5 + currentRow * 80 + 'px'
    else
        position.top = 35 + currentRow * 5 + nextRow * 80 + 'px'
    $flowsChartPath = $path.find '.flows-chart-path'
    $flowsChartPath.attr 'id', 'flows-chart-path-' + col + '-' + currentRow + '-to-' + (col+1) + '-' + nextRow
    $flowsChartPath.css position
    classList = $flowsChartPath.attr 'class'
    classList += ' flows-chart-path-stroke-' + strokeValue
    $flowsChartPath.attr 'class', classList
    $path.html()

createTooltipForPoint = (point, name, eventCount, exitCount) ->
    $point = $('<div/>').html(point)
    tooltip = '<div class="flows-chart-point-tooltip"><div class="flows-chart-point-tooltip-contents"><div class="flows-chart-point-tooltip-item flows-chart-point-tooltip-event-name"></div><hr><div class="flows-chart-point-tooltip-item flows-chart-point-tooltip-event-count"></div><hr><div class="flows-chart-point-tooltip-item flows-chart-point-tooltip-event-exit-count"></div></div></div>'
    $tooltip = $('<div/>').html(tooltip)
    name = name.toUpperCase() if name.charAt(0) != '$'
    $tooltip.find('.flows-chart-point-tooltip-event-name').text name
    eventText = if eventCount == 1 then ' event' else ' events'
    $tooltip.find('.flows-chart-point-tooltip-event-count').text eventCount.condensedValue() + eventText
    percentage = exitCount / eventCount * 100
    percentage = Math.floor percentage if percentage >= 1
    percentage = '--' if Number.isNaN(percentage) or not Number.isFinite(percentage)
    percentage = '<1' if percentage > 0 and percentage < 1
    exitText = if exitCount == 1 then ' EXIT (' else ' EXITS ('
    $tooltip.find('.flows-chart-point-tooltip-event-exit-count').text(exitCount.condensedValue() + exitText + percentage + '% DROPOFF)')
    $point.find('.flows-chart-point-contents').append($tooltip.html())
    $point.html()

getWeightsForPathsInStep = (pathsInStep) ->
    weights = []
    currentWeight = 0
    # Remove paths that are classified as 'other'
    distinctPaths = _.filter pathsInStep, (path) -> path.source != OTHER_INDEX
    bucketSize = Math.floor(distinctPaths.length / VALID_WEIGHTS.length)
    for path, pathIndex in pathsInStep
        if path.source == OTHER_INDEX
            weights.push VALID_WEIGHTS[VALID_WEIGHTS.length - 1] + 1
        else
            currentWeight = ++currentWeight if pathIndex % bucketSize == 0 and pathIndex != 0
            weights.push currentWeight
    weights

getWeightsForPathsInStepMinMax = (pathsInStep) ->
    # Remove paths that are classified as 'other', TODO: make this more robost
    distinctPaths = _.filter pathsInStep, (path) -> path.source != OTHER_INDEX
    weightsLength = VALID_WEIGHTS.length
    min = (_.min distinctPaths, (path) -> path.value).value or 0
    max = (_.max distinctPaths, (path) -> path.value).value or 0
    weights = []
    # Return greatest value first
    limits = getRange max, min, weightsLength
    for path in pathsInStep
        if path.source == OTHER_INDEX
            weights.push VALID_WEIGHTS[VALID_WEIGHTS.length - 1] + 1
        else
            currentWeight = 0
            for limit in limits
                if path.value >= limit
                    break
                else
                    ++currentWeight
            weights.push currentWeight
    weights

highlightPointsAndPaths = ($paths, direction) ->
    # Since elements are SVG, we must update classList using attr()
    for path, pathIndex in $paths
        # Highlight paths
        currentClasses = $(path).attr 'class'
        $(path).attr 'class', currentClasses + ' highlight'
        # Determine direction of path to point and highlight point
        pointRegex = null
        if direction == 'to'
            pointRegex = /-to-\d+-\d+/
        else if direction == 'from'
            pointRegex = /\d+-\d+-to-/
        pointNumber = $(path).attr('id').match(pointRegex).join().replace('-to-', '')
        $point = $('#flows-chart-point-' + pointNumber)
        $point.addClass 'highlight'
        # Use 'reference counting' to determine later on whether a node should stay highlighted
        refCount = $point.data 'refCount'
        if refCount and refCount != 0 then $point.data('refCount', ++refCount) else $point.data('refCount', 1)
    return

unhighlightPointsAndPaths = ($paths, direction) ->
    # Since elements are SVG, we must update classList using attr()
    for path, pathIndex in $paths
        # Unhighlight paths
        currentClasses = $(path).attr 'class'
        newClasses = currentClasses.replace /((\s)+highlight)|(highlight(\s)+)/, ''
        $(path).attr 'class', newClasses
        # Determine direction of path to point and unhighlight point
        if direction == 'to'
            pointRegex = /-to-\d+-\d+/
        else if direction == 'from'
            pointRegex = /\d+-\d+-to-/
        pointNumber = $(path).attr('id').match(pointRegex).join().replace('-to-', '')
        $point = $('#flows-chart-point-' + pointNumber)
        # Reference count should be set, so no need to check if it exists
        refCount = $point.data('refCount')
        $point.data('refCount', --refCount)
        # Only unhighlight if not focused
        $point.removeClass 'highlight' if refCount == 0 and not $point.hasClass 'focus'
    return

resetChart = ->
    $body = $('body')
    if $body.hasClass 'highlight-mode'
        $body.removeClass 'highlight-mode'
        $highlightPoints = $('.flows-chart-point.highlight')
        $highlightPaths = $('.flows-chart-path.highlight')
        # Remove focus & highlight classes from all points
        $highlightPoints.removeClass 'focus'
        $highlightPoints.removeClass 'highlight'
        # Reset reference count to 0 for all points
        $highlightPoints.data 'refCount', 0
        # Remove highlight class from all paths
        for path, pathIndex in $highlightPaths
            currentClasses = $(path).attr 'class'
            newClasses = currentClasses.replace /((\s)+highlight)|(highlight(\s)+)/g, ''
            $(path).attr 'class', newClasses
    return

addResetChartClickHandler = ->
    $('button#show-all-paths-button').on 'click', (event) ->
        resetChart()
        return
    return

addFlowsChartPointClickHandler = ->
    # Add click handler for .flows-chart-point
    $('.flows-chart-point').on 'click', (event) ->
        # We want to handle this here
        event.stopPropagation()
        $('body').addClass 'highlight-mode'
        # # Add animations here
        $contents = $(@).find('.flows-chart-point-contents')
        $contents.addClass 'button-click'
        $contents.one 'webkitAnimationEnd oanimationend msAnimationEnd animationend', (e) ->
            $(@).removeClass 'button-click'
        pointNumber = $(@).attr('id').match(/\d+-\d+/).join()
        if $(@).hasClass('highlight') and $(@).hasClass('focus')
            # Only remove 'highlight' class from point if reference count is 0 for point
            refCount = $(@).data 'refCount'
            # Remove 'highlight' & 'focus' classes from point
            $(@).removeClass 'highlight' if !refCount? or refCount == 0
            $(@).removeClass 'focus'
            # Determine to/from paths/points and highlight them
            $toPaths = $('[id*=flows-chart-path-' + pointNumber + ']')
            $fromPaths = $('[id*=-to-' + pointNumber + ']')
            unhighlightPointsAndPaths $toPaths, 'to'
            unhighlightPointsAndPaths $fromPaths, 'from'
        else
            # Remove 'highlight' & 'focus' classes from point
            $(@).addClass 'highlight'
            $(@).addClass 'focus'
            # Determine to/from paths/points and highlight them
            $toPaths = $('[id*=flows-chart-path-' + pointNumber + ']')
            $fromPaths = $('[id*=-to-' + pointNumber + ']')
            highlightPointsAndPaths $toPaths, 'to'
            highlightPointsAndPaths $fromPaths, 'from'
        return

destroyReport = ->
    $flowsChartDiagram = $('#flows-chart-diagram')
    $body = $('body')
    $flowsChartDiagram.empty()
    $body.removeClass 'highlight-mode'

    
createFlowsReport = (jsonResponse) ->
    # Takes in response, outputs points & paths that can be inserted into the dom
    # Generate start point
    $flowsChartDiagram = $('#flows-chart-diagram')
    $banner = $('.banner')
    # Create start point and tooltips
    startPaths = ''
    startPoint = ''
    points = ''
    paths = ''
    # Create first column of points
    # Create chart diagram
    steps = jsonResponse[0]
    if !steps?
        $bannerIcon = $banner.find '.banner-icon'
        $bannerTitle = $banner.find '.banner-title'
        $bannerMessage = $banner.find '.banner-message'
        # Show no results message
        $bannerIcon.removeClass 'banner-icon-get-started'
        $bannerIcon.addClass 'banner-icon-no-results'
        $bannerTitle.text 'NO RESULTS'
        $bannerMessage.text 'Please try your request with different parameters'
        $banner.removeClass 'hidden'
        $flowsChartDiagram.empty()
        return
    numberOfSteps = steps.length
    for step, col in steps
        if col == 0
            event = step.nodes[col]
            startPoint = createPoint event.name, event.value, event.exit, false
            startPoint = placePoint startPoint, 0, 0
            startPoint = createTooltipForPoint startPoint, event.name, event.value, event.exit
            # Create start paths
            startPaths = createStartPaths(step.links.length)
        else
            endPoint = col == numberOfSteps - 1
            for event, row in step.nodes
                event.name = 'Other (' + step.other.condensedValue() + ' events)' if event.name == 'Other'
                point = createPoint event.name, event.value, event.exit, endPoint
                point = placePoint point, row, col
                point = createTooltipForPoint point, event.name, event.value, event.exit
                points = point + points
            #weights = getWeightsForPathsInStep step.links
            weights = getWeightsForPathsInStepMinMax step.links
            for pathInfo, index in step.links
                path = createPath col, pathInfo.source, pathInfo.target, weights[index]
                paths += path

    # Remove contents (if any) before adding flows report
    $flowsChartDiagram.prepend paths
    $flowsChartDiagram.prepend points
    $flowsChartDiagram.prepend startPaths
    $flowsChartDiagram.prepend startPoint

    addFlowsChartPointClickHandler()
    addResetChartClickHandler()
    return

module.exports.destroyReport = destroyReport
module.exports.createFlowsReport = createFlowsReport
