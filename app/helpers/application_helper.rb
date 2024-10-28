module ApplicationHelper
  def flash_color(type)
    case type.to_sym
    when :success then "text-green-800 bg-green-50 dark:text-green-400"
    when :danger then "text-red-800 bg-red-50 dark:text-red-400"
    else "text-yellow-800 bg-yellow-50 dark:text-yellow-400"
    end
  end

  def page_title(title = "")
    base_title = "app_name"
    title.present? ? "#{title} - #{base_title}" : base_title
  end
end
