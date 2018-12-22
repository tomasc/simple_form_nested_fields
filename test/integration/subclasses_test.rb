require 'test_helper'

describe SimpleFormNestedFields, :capybara do
  include Actions

  before { visit new_my_doc_path }

  it 'includes select for subclasses', js: true do
    within(:css, '.simple_form_nested_fields--variants') do
      page.must_have_selector 'select'

      within(:css, 'select') do
        MyDoc::Variant.subclasses.each do |cls|
          page.must_have_selector "option[value='#{cls}']"
        end
      end
    end
  end

  it 'allows to add an item', js: true do
    within(:css, '.simple_form_nested_fields--variants') do
      add_item('MyDoc::Variant::One')
      within(:css, ".simple_form_nested_fields__item--new[data-class='MyDoc::Variant::One']") do
        page.must_have_selector 'div.input.my_doc_variants_one'
      end

      add_item('MyDoc::Variant::Two')
      within(:css, ".simple_form_nested_fields__item--new[data-class='MyDoc::Variant::Two']") do
        page.must_have_selector 'div.input.my_doc_variants_two'
      end
    end
  end
end
