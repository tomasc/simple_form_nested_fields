module Selectors
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
