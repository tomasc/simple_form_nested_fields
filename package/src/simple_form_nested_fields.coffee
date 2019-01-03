import Plugin from './plugin'

import Links from './__links'
import SortableFields from './__sortable_fields'

export default class SimpleFormNestedFields extends Plugin
  @defaults =
    name: 'SimpleFormNestedFields'
    debug: false

  init: ->
    @Links = new Links(@element)
    @SortableFields = new SortableFields(@element) if @is_sortable()

  destroy: ->
    @Links.destroy() if @Links
    @Links = undefined

    @SortableFields.destroy() if @SortableFields
    @SortableFields = undefined

  is_sortable: -> @element.classList.contains('simple_form_nested_fields--sortable')
