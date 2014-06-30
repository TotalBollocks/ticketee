require 'spec_helper'

feature "Deleting projects" do
  scenario "clicking delete link" do
    project = create :project

    visit '/'
    click_link project.name
    click_link 'Delete Project'

    expect(page).to have_content 'Project has been destroyed'

    visit '/'

    expect(page).to_not have_content project.name
  end
  
end