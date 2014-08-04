module SpecimenHelper
  def definition(item, field, value: item.send(field))
    if value and not value.blank?
      %Q{<dt class="#{css_class(field)}">#{field.to_s.humanize}</dt>
         <dd class="#{css_class(field)}">#{value}</dd>}.html_safe
    end
  end
end
