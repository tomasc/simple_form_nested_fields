require 'test_helper'

describe SimpleFormNestedFields, :capybara do
  let(:body) { 'Foo bar' }

  before do
    visit new_my_doc_path
    within(:css, '.simple_form_nested_fields--titles') { add_item }
  end

  it(nil, js: true) { page.must_have_selector '.simple_form_nested_fields__item--new' }

  describe 'removes an item when clicking the remove link' do
    before do
      remove_item
    end

    it(nil, js: true) { page.wont_have_selector '.simple_form_nested_fields__item--new' }
  end

  describe 'allows to store the document' do
    before do
      fill_in('Body', with: body)
      submit_form
    end

    it(nil, js: true) { MyDoc.first.titles.first.body.must_equal body }
  end

  private

  def add_item
    find(:css, '.simple_form_nested_fields__link--add').click
  end

  def remove_item
    find(:css, '.simple_form_nested_fields__link--remove').click
  end

  def submit_form
    find(:css, 'input[type="submit"]').click
  end
end
