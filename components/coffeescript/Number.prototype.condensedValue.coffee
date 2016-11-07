if not Number::condensedValue
    constants =
        TRILLION: 1e12
        BILLION: 1e9
        MILLION: 1e6
        THOUSAND: 1e3
        HUNDRED: 100
    Number::condensedValue = ->
        formatHelper = (value) ->
            # Assumes passed-in number will not be of the form XXXX.0
            isDecimal = value % 1 isnt 0
            result = if isDecimal and value < 100 then value.toFixed 1 else Math.floor value
        value = @valueOf()
        isDecimal = value % 1 isnt 0
        switch
            when value >= constants.TRILLION then (formatHelper value / constants.TRILLION) + 'T'
            when value >= constants.BILLION then (formatHelper value / constants.BILLION) + 'B'
            when value >= constants.MILLION then (formatHelper value / constants.MILLION) + 'M'
            when value >= constants.THOUSAND then (formatHelper value / constants.THOUSAND) + 'K'
            when value >= constants.HUNDRED then (formatHelper value)
            when value < constants.HUNDRED and isDecimal then @toFixed 1
            else @
