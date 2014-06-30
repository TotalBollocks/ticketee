module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts.unshift("Ticketee")).join(" - ")
      end
    end
  end
end
