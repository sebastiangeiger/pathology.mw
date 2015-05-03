class ActionView::Helpers::FormBuilder
  def combo_box(method, values, options = {})
    text_field(method, options.merge(data: { chosen_values: values }))
  end

  def chosen_select(method, choices, options = {}, html_options = {})
    select(method, choices, options, html_options.merge(data: { infect_with_chosen: true }))
  end
end
