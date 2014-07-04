require 'spec_helper'

feature "Deleting tickets" do
  let!(:project) {create :project}
  let!(:ticket) {create :ticket, project: project}
  let(:user) {create :user}
  
  scenario "Deleting a ticket" do
    define_permission user, "view", project
    define_permission user, "delete tickets", project
    sign_in_as user
    click_link project.name
    click_link ticket.title
    click_link "Delete Ticket"
    
    expect(page).to have_content "Ticket has been deleted"
    expect(current_url).to eq project_url(project)
  end
end