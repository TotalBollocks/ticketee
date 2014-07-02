module ControllerHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |c|
  c.include ControllerHelpers, type: :controller
end