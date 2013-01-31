do ($ = jQuery) ->
  $.fn.ajaxForm = (options = {}) ->

    settings=
      errorClass: 'error-field'
      showErrorMessage: true
      errorMessageFormat: '<div class="error-message">{message}</div>'
      insertMessage: 'before'
      onRequestStart: ->
      onRequestEnd: ->
      onSuccess: ->
      onErrors: ->
      onError: ->

    if $.type(options) is 'object'
      settings = $.extend(settings, options)
      unless ['after', 'before'].indexOf(settings.insertMessage) > -1
        settings.insertMessage = 'before'
    else if $.type(options) is 'function'
      settings.onSuccess = (data) ->
        options(data)

    $(@).each ->
      new AjaxForm(@, settings)

  class AjaxForm

    constructor: (element, settings) ->
      @el = element
      @settings = settings
      @method = $(@el).find('[name=_method]').val() || $(@el).attr('method') || 'post'
      @url = $(@el).attr('action')
      $(element).on 'submit', (event) =>
        event.preventDefault()
        @performRequest()

    performRequest: ->
      @settings.onRequestStart()
      data = $(@el).serialize()
      $.ajax
        type: @settings.method || @method
        url:  @url
        data: data
        success: (json) =>
          @settings.onRequestEnd()
          if json.errors is undefined
            window.location = json.redirect unless json.redirect is undefined
            @settings.onSuccess(json)
          else
            @settings.onErrors(json)
            @applyErrors(json.errors)

        error: (xhr) =>
          @settings.onRequestEnd()
          @settings.onError(xhr)

    applyErrors: (errors) ->
      @clearErrors()
      $.each errors, (key, val) =>
        value = if $.isArray(val) then val[0] else val
        @addError($(@el).find("[name*=#{key}]"), value)

    addError: (field, message) ->
      field.addClass(@settings.errorClass)
      if @settings.showErrorMessage is true
        error = @settings.errorMessageFormat.replace('{message}', message)
        field[@settings.insertMessage](error)

    clearErrors: ->
      fields = $(@el).find(".#{@settings.errorClass}")
      fields.removeClass(@settings.errorClass)
      if @settings.showErrorMessage is true
        method = if @settings.insertMessage is 'before' then 'prev' else 'next'
        fields[method]().remove()