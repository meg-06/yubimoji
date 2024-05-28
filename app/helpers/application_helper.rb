module ApplicationHelper
  def daisyui_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "alert alert-success"
    when :danger
      "alert alert-error"
    else
      "alert alert-info"
    end
  end
end
