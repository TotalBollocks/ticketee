class TicketsController < ApplicationController
  before_action :require_signin!
  before_action :find_project
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_edit!, only: [:edit, :update]
  before_action :authorize_destroy!, only: :destroy
  
  def search
    @tickets = @project.tickets.search(params[:search])
    render "projects/show"
  end
  
  def show
    @comment = @ticket.comments.build
    @states = State.all
  end
  
  def new
    @ticket = @project.tickets.build
    @ticket.assets.build
  end
  
  def create
    if cannot?(:tag, @project) && !current_user.admin?
      params[:ticket].delete(:tag_names)
    end
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    
    if @ticket.save
      flash[:notice] = "Ticket has been created"
      redirect_to [@project, @ticket]
    else
      flash[:notice] = "Ticket has not been created"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated"
      redirect_to [@project, @ticket]
    else
      flash[:notice] = "Ticket has not been updated"
      render 'edit'
    end
  end
  
  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted"
    redirect_to @project
  end
  
  private
  
  def authorize_edit!
    if !current_user.admin? && cannot?("edit tickets".to_sym, @project)
      flash[:alert] = "You cannot edit tickets on this project"
      redirect_to [@project, @ticket]
    end
  end
  
  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:alert] = "You cannot create tickets on this project"
      redirect_to @project
    end
  end
  
  def authorize_destroy!
    if !current_user.admin? && cannot?("delete tickets".to_sym, @project)
      flash[:alert] = "You cannot delete tickets on this project"
      redirect_to @project
    end
  end
  
  def ticket_params
    params.require(:ticket).permit(:title, :description, :tag_names, assets_attributes: [:asset])
  end
  
  def find_project
    @project = Project.for(current_user).find params[:project_id]
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found"
      redirect_to root_path
  end
  
  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end
end
