class Admin::PermissionsController < Admin::BaseController
  before_action :find_user
  
  def index
    @ability = Ability.new(@user)
    @projects = Project.all
  end
  
  def set
    @user.permissions.clear
    params[:permissions].each do |id, permissions|
      project = Project.find id
      permissions.each do |action, checked|
        Permission.create!( user: @user, thing: project, action: action)
      end
    end
    flash[:notice] = "Permissions updated"
    redirect_to [:admin, @user, :permissions]
  end
  
  private
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
