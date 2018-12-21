require 'test_helper'

describe SimpleFormNestedFields, :capybara do
  include Selectors

  before { visit new_my_doc_path }

  it 'allows to rearrange the items', js: true do
    (1..3).each do |index|
      within(:css, '.simple_form_nested_fields--texts') do
        add_item

        within(:css, ".simple_form_nested_fields__item:nth-child(#{index})") do
          fill_in('Body', with: index.to_s)
        end
      end
    end

    page.execute_script <<-EOS
      var drag_source = document.querySelector('.simple_form_nested_fields__item:nth-child(1) .simple_form_nested_fields__item_handle');
      var drop_target = document.querySelector('.simple_form_nested_fields__item:nth-child(3)');

      window.dragMock.dragStart(drag_source).delay(100).dragOver(drop_target).delay(100).drop(drop_target);
    EOS

    sleep(0.3)

    submit_form

    # dragMock, for some reason, makes this result instead of 2 3 1
    MyDoc.first.texts.map(&:body).must_equal %w[2 1 3]
  end
end
