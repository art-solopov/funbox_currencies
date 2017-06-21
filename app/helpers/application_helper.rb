module ApplicationHelper
  def error_for(model, field)
    return if model.errors[field].blank?
    content_tag(
      :div,
      model.errors.messages[field].join('; '),
      class: 'text-danger'
    )
  end
end
