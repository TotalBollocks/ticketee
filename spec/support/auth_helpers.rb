module AuthHelpers
  def sign_in_as(user)
    visit '/'
    click_link "Sign in"
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content "You have signed in"
  end
  
  def define_permission(user, action, thing)
    Permission.create! user: user, action: action, thing: thing
  end
  
  def check_permission_box(name, object)
    check "permissions_#{object.id}_#{name}"
  end
end

RSpec.configure do |c|
  c.include AuthHelpers, type: :feature
end