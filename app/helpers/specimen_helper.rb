module SpecimenHelper
  def definition(item, field, value: item.send(field), label: field.to_s.humanize )
    if value and not value.blank?
      %Q{<div class="#{css_class(field)}">
           <dt>#{label}</dt>
           <dd>#{value}</dd>
         </div>}.html_safe
    end
  end
end
