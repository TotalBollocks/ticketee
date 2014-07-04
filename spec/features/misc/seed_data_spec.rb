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
  end
end