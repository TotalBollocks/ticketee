require 'spec_helper'

feature "Viewing projects" do
  let(:user) {create :user}
  let!(:project) {create :project}
  
  before do
    define_permission user, :view, project
    sign_in_as user
  end
  
  scenario "Listing all projects" do
    click_link project.name
    expect(current_url).to eq project_url(project)
  end
  
  scenario "Doesnt show projects without permission" do
    hidden = create :project
    visit '/'
    expect(page).to_not have_content hidden.name
  end
end