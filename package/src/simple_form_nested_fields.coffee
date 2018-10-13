do ($ = jQuery, window, document) ->
  pluginName = 'SimpleFormNestedFields'
  defaults =
    debug: false

  class Plugin
    constructor: (@element, options) ->
      @options = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @$element = $(@element)
      @init()

    init: ->
      @$element.SimpleFormNestedFields__Links()
      @$element.SimpleFormNestedFields__Sortable() if @is_sortable()

    destroy: ->
      @$element.data('plugin_SimpleFormNestedFields__Links').destroy()
      @$element.data('plugin_SimpleFormNestedFields__Sortable').destroy()

    is_sortable: -> @element.classList.contains('simple_form_nested_fields--sortable')

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
