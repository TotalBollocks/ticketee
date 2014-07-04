module ControllerHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
  
  def define_permission(user, action, thing)
    Permission.create! user: user, action: action, thing: thing
  end
end

RSpec.configure do |c|
  c.include ControllerHelpers, type: :controller
end