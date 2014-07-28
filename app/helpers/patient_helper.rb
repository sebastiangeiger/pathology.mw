module PatientHelper
  def optional_attribute(attribute)
    if attribute.nil? or attribute.blank?
      "<span class='not-set'>not set</span>".html_safe
    else
      attribute
    end
  end
end

