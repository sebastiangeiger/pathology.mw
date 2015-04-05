module PatientHelper
  def patient_info_row(attribute, patient, method: attribute.downcase.gsub(' ', '_').to_sym)
    value = patient.send(method)
    %(<div class="row">
         <div class="small-4 columns">#{attribute}:</div>
         <div class="small-8 columns #{css_class(attribute)}">#{optional_attribute(value)}</div>
       </div>).html_safe
  end

  def optional_attribute(attribute)
    if attribute.nil? || attribute.blank?
      "<span class='not-set'>not set</span>".html_safe
    else
      attribute
    end
  end
end
