require 'spec_helper'

feature 'Editing projects' do
  before do
    project = create :project
    admin = create :admin

    sign_in_as admin
    click_link project.name
    click_link 'Edit Project'
  end
  
  scenario "Updating a project" do
    fill_in 'Name', with: "TextMate 2 Beta"
    click_button 'Update Project'
    
    expect(page).to have_content 'Project has been updated'
  end
  
  scenario "Updating with bad attributes" do
    fill_in "Name", with: ""
    click_button 'Update Project'
    
    expect(page).to have_content 'Project has not been updated'
  end
end