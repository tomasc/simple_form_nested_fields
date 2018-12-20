#= require sortablejs/1.6.1/index.js

do ($ = jQuery, window, document) ->
  pluginName = 'SimpleFormNestedFields__Sortable'
  defaults =
    debug: false

  class Plugin
    constructor: (@element, options) ->
      @$element = $(@element)
      @$simple_form_nested_fields = @$element.data('plugin_SimpleFormNestedFields')
      @options = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @init()

    init: ->
      return if @sortable

      @sortable = new Sortable(
        @get_items_container()[0],

        animation: 150,
        draggable: '.simple_form_nested_fields__item',
        ghostClass: 'simple_form_nested_fields__item--ghost',
        handle: '.simple_form_nested_fields__item_handle',

        # TODO: onAdd is not being triggered?
        onAdd: (e) => @update_item_positions(),
        onUpdate: (e) => @update_item_positions(),
        onRemove: (e) => @update_item_positions(),
      )

      @$element.on "update_item_positions.#{@_name}", (e) =>
        e.stopPropagation()
        @update_item_positions()

      @update_item_positions()

    destroy: ->
      @sortable.destroy() if @sortable

    update_item_positions: ->
      @get_items().each (i, el) =>
        $(el).find('input[name*="position"]').val(i+1)

    get_items: -> @get_items_container().find('.simple_form_nested_fields__item')
    get_items_container: -> @$element.find('.simple_form_nested_fields__items')

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
