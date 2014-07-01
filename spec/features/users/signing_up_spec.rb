require 'spec_helper'

feature "Signing up" do
  scenario "Successful sign up" do
    visit '/'
    click_link "Sign up"
    
    fill_in "Name", with: "Jared"
    fill_in "Email", with: "llol@lol.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_button "Sign up"
    
    expect(page).to have_content "You have signed up!"
  end
end