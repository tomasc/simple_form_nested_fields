module SimpleFormNestedFields
  class NestedFieldsBuilder
    extend Forwardable

    BASE_DOM_CLASS = 'simple_form_nested_fields'.freeze
    CHILD_INDEX_STRING = '__INDEX_PLACEHOLDER__'.freeze

    attr_accessor :builder, :template, :record_name, :record_object, :options

    def initialize(builder, template, record_name, record_object, options = {})
      @builder = builder
      @template = template
      @record_name = record_name
      @record_object = record_object
      @options = options
    end

    def_delegators :builder, :object, :object_name, :simple_fields_for
    def_delegators :template, :concat, :content_tag, :hidden_field_tag, :select_tag, :options_for_select, :link_to, :render

    def nested_fields_for
      content_tag(:div, class: wrapper_class) do
        concat nested_fields_title
        concat nested_fields_items
        concat nested_fields_links

        item_classes.each do |cls|
          concat nested_fields_template(cls)
        end
      end
    end

    private

    def wrapper_class
      modifiers = is_sortable? ? [record_name, :sortable] : record_name
      bem_class(m: modifiers)
    end

    def is_sortable?
      options.fetch(:sortable, false)
    end

    def multiple_item_classes?
      item_classes.length > 1
    end

    def item_classes
      options.fetch(:item_classes) do
        return relation.klass.descendants if relation.klass.descendants.present?
        [relation.klass]
      end
    end

    def partial_path(cls)
      options.fetch(:partial) do
        File.join(object.model_name.collection, cls.model_name.collection, 'fields')
      end
    end

    def relation
      object.reflect_on_association(record_name)
    end

    def nested_fields_title
      dom_class = bem_class(e: :title)
      title = relation.klass.model_name.human.pluralize
      content_tag(:div, title, class: dom_class).html_safe
    end

    def nested_fields_item_class_name(cls)
      return unless multiple_item_classes?
      dom_class = bem_class(e: :item_class_name)
      content_tag(:div, cls.model_name.human, class: dom_class).html_safe
    end

    def nested_fields_items
      content_tag(:div, class: bem_class(e: :items)) do
        simple_fields_for(record_name, record_object, options) do |fields|
          dom_class = bem_class(e: :item)
          dom_data = { id: fields.object.id.to_s, class: fields.object.class.to_s }

          content_tag(:div, class: dom_class, data: dom_data) do
            concat nested_fields_item_class_name(fields.object.class)
            concat nested_fields_item_handle
            concat nested_fields__type_input(fields)
            concat nested_fields_position_input(fields)
            concat render(partial_path(fields.object.class), fields: fields)
            concat link_to_remove(fields)
          end
        end
      end
    end

    def nested_fields_links
      dom_class = bem_class(e: :links)
      content_tag(:div, class: dom_class) do
        concat select_for_add
        concat link_to_add
      end.html_safe
    end

    def select_for_add
      dom_class = bem_class(e: :select, m: :add)
      dom_style = ""
      dom_style = "display: none;" unless multiple_item_classes?
      select_tag nil, options_for_select(item_classes.map { |kls| [kls.model_name.human, kls.to_s] }), class: dom_class, style: dom_style
    end

    def link_to_add
      label = options.fetch(:label_add, ::I18n.t(:add, scope: %i[simple_form_nested_fields links], model_name: relation.klass.model_name.human))
      dom_class = bem_class(e: :link, m: :add)
      dom_data = { turbolinks: 'false' }
      link_to(label, '#', class: dom_class, data: dom_data).html_safe
    end

    def nested_fields_item_handle
      return unless is_sortable?
      dom_class = bem_class(e: :item_handle)
      content_tag(:div, nil, class: dom_class).html_safe
    end

    def nested_fields_position_input(fields)
      return unless is_sortable?
      fields.input(:position, as: :hidden).html_safe
    end

    def nested_fields__type_input(fields)
      return unless fields.object.respond_to?(:_type)
      fields.input(:_type, as: :hidden).html_safe
    end

    def nested_fields_template(cls)
      content_tag :template, data: { class: cls.to_s } do
        content_tag :div, class: bem_class(e: :item), data: { class: cls.to_s } do
          simple_fields_for(record_name, cls.new, child_index: CHILD_INDEX_STRING) do |fields|
            concat nested_fields_item_class_name(cls)
            concat nested_fields_item_handle
            concat nested_fields__type_input(fields)
            concat nested_fields_position_input(fields)
            concat render(partial_path(cls), fields: fields)
            concat link_to_remove(fields)
          end
        end
      end
    end

    def destroy_field_tag(fields)
      return if fields.object.new_record?
      hidden_field_tag("#{fields.object_name}[_destroy]", fields.object._destroy).html_safe
    end

    def link_to_remove(fields, options = {})
      label = options.fetch(:label, ::I18n.t(:remove, scope: %i[simple_form_nested_fields links]))
      dom_class = bem_class(e: :link, m: :remove)
      dom_data = { turbolinks: 'false' }
      [
        destroy_field_tag(fields),
        link_to(label, '#', class: dom_class, data: dom_data)
      ].reject(&:blank?).join.html_safe
    end

    def bem_class(e: nil, m: nil)
      SimpleFormNestedFields::Bem.new(b: BASE_DOM_CLASS, e: e, m: m).to_s
    end
  end
end
