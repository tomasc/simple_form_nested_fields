module SimpleFormNestedFields
  module ActionViewExtension
    module Builder
      def nested_fields_for(record_name, record_object = nil, options = {}, &block)
        SimpleFormNestedFields::NestedFieldsBuilder.new(self, @template, record_name, record_object, options).nested_fields_for(&block)
      end
    end
  end
end

module ActionView::Helpers
  class FormBuilder
    include SimpleFormNestedFields::ActionViewExtension::Builder
  end
end
