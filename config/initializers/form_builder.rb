class ActionView::Helpers::FormBuilder
  def combo_box(method, values, options = {})
    text_field(method, options.merge(data: { chosen_values: values }))
  end
end
