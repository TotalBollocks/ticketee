require 'spec_helper'

feature "Viewing projects" do
  scenario "Listing all projects" do
    project = create :project, name: "TextMate 2"
    visit '/'
    click_link "TextMate 2"
    expect(current_url).to eq project_url(project)
  end
end