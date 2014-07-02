module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts.unshift("Ticketee")).join(" - ")
      end
    end
  end
  
  def admin_only(&block)
    block.call if current_user.try(:admin?)
  end
end
