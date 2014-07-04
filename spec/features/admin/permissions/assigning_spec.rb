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
  
  scenario "giving create tickets permission" do
    check_permission_box "view", project
    check_permission_box "create tickets", project
    click_button "Update"
    
    click_link "Sign out"
    sign_in_as user
    click_link project.name
    click_link "Create Ticket"
    fill_in "Title", with: "Some text"
    fill_in "Description", with: "Some more text about stuff"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has been created"
  end
  
  scenario "giving edit tickets permission" do
    check_permission_box "edit tickets", project
    check_permission_box "view", project
    click_button "Update"
    
    click_link "Sign out"
    sign_in_as user
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
    fill_in "Title", with: "New titleeee"
    click_button "Update Ticket"
    
    expect(page).to have_content "Ticket has been updated"
  end
  
  scenario "giving delete tickets permission" do
    check_permission_box "delete tickets", project
    check_permission_box "view", project
    click_button "Update"
    
    click_link "Sign out"
    sign_in_as user
    click_link project.name
    click_link ticket.title
    click_link "Delete Ticket"

    expect(page).to have_content "Ticket has been deleted"
  end
end