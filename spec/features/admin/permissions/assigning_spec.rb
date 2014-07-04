require 'spec_helper'

feature "Assigning permissions" do
  let!(:admin){create :admin}
  let!(:user){create :user}
  let!(:project){create :project}
  let!(:ticket){create :ticket, project: project}
  
  before do
    sign_in_as admin
    
    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Permissions"
  end
  
  scenario "giving view project permission" do
    check_permission_box "view", project
    click_button "Update"
    click_link "Sign out"
    
    sign_in_as user
    expect(page).to have_content project.name
  end
end