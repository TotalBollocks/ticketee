require 'spec_helper'

feature "Editing tickets" do
  let!(:project) {create :project}
  let!(:ticket) {create :ticket, project: project}
  let(:user) {create :user}
  
  before do
    visit '/'
    sign_in_as(user)
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
  end
  
  scenario "updating a ticket" do
    fill_in "Title", with: "New Title"
    click_button "Update Ticket"
    
    expect(page).to have_content "Ticket has been updated"
    within "#ticket h2" do
      expect(page).to have_content "New Title"
    end
  end
  
  scenario "updating with invalid information" do
    fill_in "Title", with: ""
    click_button "Update Ticket"
    
    expect(page).to have_content "Ticket has not been updated"
  end
end