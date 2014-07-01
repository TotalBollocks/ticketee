require 'spec_helper'

feature "Creating tickets" do
  before do
    project = create :project
    
    visit '/'
    click_link project.name
    click_link "Create Ticket"
  end
  
  scenario "creating a ticket" do
    fill_in "Title", with: "Bad project"
    fill_in "Description", with: "So so baaaaaaaaad"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has been created"
  end
  
  scenario "creating ticket with invalid attributes" do
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end
  
  scenario "where description is less than 10 chars" do
    fill_in "Title", with: "Internet Explorer"
    fill_in "Description", with: "Sucks"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Description is too short"
  end
end