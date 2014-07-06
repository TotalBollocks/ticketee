class TagsController < ApplicationController
  before_action :find_ticket
  
  def remove
    if can?(:tag, @ticket.project) || current_user.admin?
      @tag = @ticket.tags.find params[:id]
      @ticket.tags -= [@tag]
      @ticket.save
    else
      render nothing: true
    end
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find params[:ticket_id]
  end
end
