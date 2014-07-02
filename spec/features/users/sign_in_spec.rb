require 'spec_helper'

feature "Signing in" do
  let(:user) {create :user}
  
  scenario "sign in successfully" do
    visit '/'
    click_link "Sign in"
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"
    
    expect(page).to have_content "You have signed in"
  end
end