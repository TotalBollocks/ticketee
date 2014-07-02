require 'spec_helper'

feature "Creating users" do
  let(:admin) {create :admin}
  
  before do
    sign_in_as admin
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end
  
  scenario "making a new user" do
    fill_in "Name", with: "Noob"
    fill_in "Email", with: "new@example.com"
    fill_in "Password", with: "secret"
    click_button "Create User"
    
    expect(page).to have_content "User has been created"
  end
  
  scenario "making an admin user" do
    email = "new@example.com"
    fill_in "Name", with: "Noob"
    fill_in "Email", with: email
    fill_in "Password", with: "secret"
    check "Admin"
    click_button "Create User"
    
    expect(page).to have_content "User has been created"
    within '#users' do
      expect(page).to have_content "#{email} (Admin)"
    end
  end
end