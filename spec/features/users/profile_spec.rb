require 'spec_helper'

feature "User profiles" do
  let(:user) {create :user}
  
  scenario "viewing" do
    visit user_path(user)
    
    expect(page).to have_content user.name
    expect(page).to have_content user.email
  end
end

feature "Editing user" do
  let(:user) {create :user}
  
  scenario "editing with valid info" do
    new_name = "New Name"
    
    visit user_path(user)
    click_link "Edit Profile"
    
    fill_in "Name", with: new_name
    click_button "Update Profile"
    
    expect(page).to have_content new_name
    expect(page).to have_content "Profile has been updated"
  end
end