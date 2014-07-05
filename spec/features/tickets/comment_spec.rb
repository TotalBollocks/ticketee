require 'spec_helper'

feature "Creating a comment" do
  let!(:user) {create :user}
  let!(:project) {create :project}
  let!(:ticket) {create :ticket, project: project, user: user}
  
  before do
    define_permission user, "view", project
    sign_in_as user
    click_link project.name
  end
  
  scenario "creating comment" do
    comment = "Added a comment"
    click_link ticket.title
    fill_in "Text", with: comment
    click_button "Create Comment"
    
    expect(page).to have_content "Comment has been created"
    within "#comments" do
      expect(page).to have_content comment
    end
  end
  
  scenario "Creating invalid comment" do
    click_link ticket.title
    click_button "Create Comment"
    expect(page).to have_content "Comment has not been created"
    expect(page).to have_content "Text can't be blank"
  end
end