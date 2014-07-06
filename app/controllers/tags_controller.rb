class TagsController < ApplicationController
  before_action :find_ticket
  
  def remove
    if authorized? :tag, @ticket.project
      @tag = Ticket.tags.find params[:id]
      @ticket.tags -= [@tag]
      @ticket.save
    end
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find params[:ticket_id]
  end
end
