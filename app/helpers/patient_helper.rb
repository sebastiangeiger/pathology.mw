module PatientHelper
  def patient_info_row(attribute, patient, optional: false)
    method_name = attribute.downcase.gsub(" ","_").to_sym
    value = patient.send(method_name)
    %Q{<div class="row">
         <div class="small-4 columns">#{attribute}:</div>
         <div class="small-8 columns">#{optional_attribute(value)}</div>
       </div>}.html_safe
  end
  def optional_attribute(attribute)
    if attribute.nil? or attribute.blank?
      "<span class='not-set'>not set</span>".html_safe
    else
      attribute
    end
  end
  def class_name_to_css(item)
    item.class.to_s.underscore
  end
end

