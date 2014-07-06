require 'spec_helper'

feature "Creating new states" do
  before {sign_in_as create(:admin)}
  
  scenario "making new state" do
    click_link "Admin"
    click_link "States"
    click_link "New State"
    fill_in "Name", with: "Idgaf"
#     fill_in "Background", with: "#00FF00"
#     fill_in "Color", with: "#FF00FF"
    click_button "Create State"
    
    expect(page).to have_content "State has been created"
  end
end