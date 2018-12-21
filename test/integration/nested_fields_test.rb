require 'test_helper'

describe SimpleFormNestedFields, :capybara do
  include Selectors
  
  before do
    visit new_my_doc_path
  end

  it(nil, js: true) { page.wont_have_selector '.simple_form_nested_fields__item--new' }
end
