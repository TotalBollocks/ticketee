require 'spec_helper'

feature "Viewing tickets" do
  let(:user) {create :user}
  let!(:project) {create :project, name: "TextMate 2"}
  let!(:ticket) {create :ticket, project: project}
  let!(:wrong_ticket) {create :ticket}
  
  before do
    define_permission user, "view", project
    sign_in_as user
  end
  
  scenario "Viewing tickets for a project" do
    click_link project.name
    
    expect(page).to have_content ticket.title
    expect(page).to_not have_content wrong_ticket.title
    
    click_link ticket.title
    within '#ticket h2' do
      expect(page).to have_content ticket.title
    end
    expect(page).to have_content ticket.description
  end
end