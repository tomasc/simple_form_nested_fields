require 'test_helper'

describe 'Nested Fields', :capybara do
  before { visit new_my_doc_path }

  describe 'items' do
    it 'does not have any items to begin with' do
      page.wont_have_selector '.simple_form_nested_fields__item--new'
    end

    describe 'adding and removing' do
      let(:body) { 'Foo bar' }

      before { within(:css, '.simple_form_nested_fields--titles') { add_item } }

      it 'adds an item when clicking the add link', js: true do
        page.must_have_selector '.simple_form_nested_fields__item--new'
      end

      it 'removes an item when clicking the remove link', js: true do
        remove_item
        page.wont_have_selector '.simple_form_nested_fields__item--new'
      end

      it 'allows to store the document', js: true do
        fill_in('Body', with: body)
        submit_form
        MyDoc.first.titles.first.body.must_equal body
      end
    end

    describe 'sortable' do
      before do
        (1..3).each do |index|
          within(:css, '.simple_form_nested_fields--texts') do
            add_item

            within(:css, ".simple_form_nested_fields__item:nth-child(#{index})") do
              fill_in('Body', with: "#{index}")
            end
          end
        end
      end

      it 'allows to rearrange the items', js: true do
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
