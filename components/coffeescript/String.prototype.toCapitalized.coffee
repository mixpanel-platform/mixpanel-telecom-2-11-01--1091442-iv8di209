if not String::toCapitalized
    # Capitalizes the first word in each string
    capitalizeString = (str) ->
        str.charAt(0).toUpperCase() + str.substr(1).toLowerCase()
    String::toCapitalized = ->
        @replace /\w\S*/g, capitalizeString
