module ApplicationHelper
  def is_active?(menu_point)
    if @menu_point_active == menu_point
      "active"
    else
      ""
    end
  end
end
