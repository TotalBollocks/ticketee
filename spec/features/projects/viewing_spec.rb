require 'spec_helper'

feature "Viewing projects" do
  let(:user) {create :user}
  let!(:project) {create :project}
  
  before do
    sign_in_as user
    define_permission user, :view, project
    visit '/'
  end
  
  scenario "Listing all projects" do
    click_link project.name
    expect(current_url).to eq project_url(project)
  end
end