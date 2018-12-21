require 'test_helper'

describe SimpleFormNestedFields, :capybara do
  include Selectors

  let(:body) { 'Foo bar' }

  before { visit new_my_doc_path }

  it 'allows to add an item', js: true do
    within(:css, '.simple_form_nested_fields--titles') do
      add_item
      page.must_have_selector '.simple_form_nested_fields__item--new'
    end
  end

  it 'allows to remove an item', js: true do
    within(:css, '.simple_form_nested_fields--titles') do
      add_item
      page.must_have_selector '.simple_form_nested_fields__item--new'
      remove_item
      page.wont_have_selector '.simple_form_nested_fields__item--new'
    end
  end

  it 'persists added item', js: true do
    within(:css, '.simple_form_nested_fields--titles') do
      add_item
      fill_in('Body', with: body)
    end
    submit_form

    MyDoc.first.titles.first.body.must_equal body
  end
end
