class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :find_ticket
  
  def create
    sanitize_parameters!
    
    @comment = @ticket.comments.build(ticket_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "Comment has been created"
      redirect_to [@ticket.project, @ticket]
    else
      @states = State.all
      flash[:notice] = "Comment has not been created"
      render "tickets/show"
    end
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
  
  def ticket_params
    params.require(:comment).permit(:text, :state_id, :tag_names)
  end
  
  def sanitize_parameters!    
    if params[:comment][:state_id] && cannot?(:"change states", @ticket.project)
      params[:comment].delete(:state_id)
    end
    
    if params[:comment][:tag_names] && cannot?(:tag, @ticket.project)
      params[:comment].delete(:tag_names)
    end
  end  
end
