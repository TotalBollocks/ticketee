require 'spec_helper'

feature "Editin users" do
  let!(:admin) {create :admin}
  let!(:user) {create :user}
  
  before do
    sign_in_as admin
    click_link "Admin"
    click_link "Users"
    click_link user.to_s
    click_link "Edit User"
  end
  
  scenario "editing a user" do
    fill_in "Email", with: "lol@lol.com"
    click_button "Update User"
    
    expect(page).to have_content "User has been updated"
    within "#users" do
      expect(page).to have_content "lol@lol.com"
      expect(page).to_not have_content user.email
    end
  end
  
  scenario "toggling admn status" do
    check "Admin"
    click_button "Update User"
    
    expect(page).to have_content "User has been updated"
    within "#users" do
      expect(page).to have_content "#{user.email} (Admin)"
    end
  end
end