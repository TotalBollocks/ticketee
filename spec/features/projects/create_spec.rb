require 'spec_helper'

describe "Creating projects" do
  specify "can create a project" do
    visit '/'
    
    click_link "New Project"
    
    fill_in "Name", with: "TextMate 2"
    fill_in "Description", with: "A text editor"
    click_button "Create Project"
    
    expect(page).to have_content 'Project has been created'
  end
end