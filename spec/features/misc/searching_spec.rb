require 'spec_helper'

feature "Searching" do
  let!(:user) {create :user}
  let!(:project) {create :project}
  let!(:ticket1) do
    state = State.create name: "Open"
    create :ticket, project: project, tag_names: "round1", state: state
  end
  let!(:ticket2) do
    state = State.create name: "Closed"
    create :ticket, project: project, tag_names: "round2", state: state
  end
  
  before do
    define_permission user, "view", project
    define_permission user, "tag", project
    sign_in_as user
    click_link project.name
  end
  
  scenario "Finding by tag" do
    fill_in "Search", with: "tag:round1"
    click_button "Search"
    within "#tickets" do
      expect(page).to have_content ticket1.title
      expect(page).to_not have_content ticket2.title
    end
  end
  
  scenario "Finding by state" do
    fill_in "Search", with: "state:Open"
    click_button "Search"
    within "#tickets" do
      expect(page).to have_content ticket1.state
      expect(page).to_not have_content ticket2.state
    end
  end
end