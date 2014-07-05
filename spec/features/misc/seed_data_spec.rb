require 'spec_helper'

feature "Seed data" do
  scenario "Can access admin account and a project" do
    load Rails.root + "db/seeds.rb"
    visit '/'
    click_link "Sign in"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "password"
    click_button "Sign in"
    expect(page).to have_content "You have signed in"
    expect(page).to have_content "Admin"
    expect(page).to have_content "Ticketee Beta"
    
    click_link "Ticketee Beta"
    click_link "Create Ticket"
    fill_in "Title", with: "Comment crap"
    fill_in "Description", with: "it has to have a sttate"
    click_button "Create Ticket"
    
    within "#comment_state_id" do
      expect(page).to have_content "New"
      expect(page).to have_content "Open"
      expect(page).to have_content "Closed"
    end
    
  end
end