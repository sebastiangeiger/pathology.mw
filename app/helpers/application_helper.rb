module ApplicationHelper
  def is_active?(menu_point)
    if @menu_point_active == menu_point
      "active"
    else
      ""
    end
  end
  def css_class(name)
    name.to_s.gsub("_", "-").downcase
  end
end
