require 'spec_helper'

feature "Making default" do
  before do
    load Rails.root + "db/seeds.rb"
    sign_in_as create(:admin)
  end
  
  scenario "making state default" do
    click_link "Admin"
    click_link "States"
    within state_line_for("New") do
      click_link "Make Default"
    end
    
    expect(page).to have_content "New is now the default state"
  end
end