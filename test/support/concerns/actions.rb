module Actions
  private

  def add_item(class_name = nil)
    within(:css, '.simple_form_nested_fields__links') do
      if class_name.present?
        within(:css, '.simple_form_nested_fields__select--add') do
          find("option[value='#{class_name}']").click
        end
      end
      find(:css, '.simple_form_nested_fields__link--add').click
    end
  end

  def remove_item
    find(:css, '.simple_form_nested_fields__link--remove').click
  end

  def submit_form
    find(:css, 'input[type="submit"]').click
  end
end
