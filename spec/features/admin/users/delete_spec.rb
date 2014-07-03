require 'spec_helper'

feature "Deleting users" do
  let!(:admin) {create :admin}
  let!(:user) {create :user}
  
  before do
    sign_in_as admin
    click_link "Admin"
    click_link "Users"
  end
  
  scenario "Deleting a user" do
    click_link user.to_s
    click_link "Delete User"
    
    expect(page).to have_content "User has been deleted"
    expect(page).to_not have_content user.to_s
  end
  
  scenario "Cant delete yourself" do
    click_link admin.to_s
    click_link "Delete User"
    
    expect(page).to have_content "You cannot delete yourself"
  end
end