require 'test_helper'

class SimpleFormNestedFields::NestedFieldsBuilderTest < ActionView::TestCase
  let(:form) { SimpleForm::FormBuilder.new(:my_doc, MyDoc.new, ActionView::Base.new, {}) }
  let(:my_doc) { MyDoc.new }

  it { form.must_respond_to :nested_fields_for }

  describe '#nested_fields' do
    let(:options) { {} }
    let(:collection) { nil }
    let(:nested_fields) {
      result = nil
      simple_form_for my_doc do |f|
        result = f.nested_fields_for :texts, collection, options
      end
      result
    }

    it { nested_fields.must_match(/simple_form_nested_fields__title/) }
    it { nested_fields.must_match(/simple_form_nested_fields__items/) }
    it { nested_fields.must_match(/simple_form_nested_fields__link--add/) }

    describe 'sortable' do
      let(:options) { { sortable: true } }

      it { nested_fields.must_match(/simple_form_nested_fields--sortable/) }
    end

    describe 'with items' do
      before do
        (1..5).each { |index| my_doc.texts.build(body: index) }
        my_doc.save!
      end

      # 1 extra accounts for template
      it { nested_fields.scan(/simple_form_nested_fields__item\"/).length.must_equal 5 + 1 }
    end
  end
end
