require 'spec_helper'

feature "Searching" do
  let!(:user) {create :user}
  let!(:project) {create :project}
  let!(:ticket1) {create :ticket, project: project, tag_names: "round1"}
  let!(:ticket2) {create :ticket, project: project, tag_names: "round2"}
  
  before do
    define_permission user, "view", project
    define_permission user, "tag", project
    sign_in_as user
    click_link project.name
  end
  
  scenario "Findin by tag" do
    fill_in "Search", with: "tag:round1"
    click_button "Search"
    within "#tickets" do
      expect(page).to have_content ticket1.title
      expect(page).to_not have_content ticket2.title
    end
  end
end