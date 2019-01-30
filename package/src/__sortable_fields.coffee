import Plugin from './plugin'

import Sortable from 'sortablejs'

export default class SortableFields extends Plugin
  @defaults =
    name: 'SimpleFormNestedFields__SortableFields'
    debug: false

  init: ->
    return if !!@sortable

    @sortable = new Sortable(
      @get_items_container()[0],

      animation: 150,
      draggable: '.simple_form_nested_fields__item',
      ghostClass: 'simple_form_nested_fields__item_ghost',
      handle: '.simple_form_nested_fields__item_handle',

      # TODO: onAdd is not being triggered?
      onAdd: (e) => @update_item_positions(),
      onUpdate: (e) => @update_item_positions(),
      onRemove: (e) => @update_item_positions(),
    )

    @$element.on "update_item_positions.SimpleFormNestedFields__SortableFields", (e) =>
      e.stopPropagation()
      @update_item_positions()

    @update_item_positions()

  destroy: ->
    @$element.off '.SimpleFormNestedFields__SortableFields'
    @sortable.destroy() if @sortable

  update_item_positions: ->
    @get_items().each (i, el) =>
      $(el).find('input[name*="position"]').val(i+1)

  get_items: -> @get_items_container().find('.simple_form_nested_fields__item')
  get_items_container: -> @$element.find('.simple_form_nested_fields__items')
