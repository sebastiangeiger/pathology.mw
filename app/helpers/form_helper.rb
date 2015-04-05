module FormHelper
  def form_errors_summary(model)
    if model.errors.any?
      render partial: 'shared/form_errors_summary',
             locals: {
               model_name: model.class.model_name.human
             }
    end
  end
end
