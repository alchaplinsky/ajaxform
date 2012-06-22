do ($ = jQuery) ->
  $.fn.ajaxFrom = (options = {}) ->
    settings: {}
    $.extend(settings, options)