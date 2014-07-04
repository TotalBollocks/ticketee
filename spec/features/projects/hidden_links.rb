require 'spec_helper'

feature "Hidden links" do
  let(:user) {create :user}
  let(:admin) {create :admin}
  let(:project) {create :project}
  let(:ticket) {create :ticket, project: project}
  
  context "Regular user" do
    before do
      define_permission user, "view", project
      sign_in_as user
    end
    
    specify "cannot see new project link" do
      assert_no_link_for "New Project"
    end
    
    specify "cannot see edit project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    
    specify "cannot see delete project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
    
    specify "Create ticket link is shown if permission" do
      define_permission user, "create tickets", project
      visit project_path(project)
      assert_link_for "Create Ticket"
    end
    
    specify "Create link isnt shown without permission" do
      visit project_path(project)
      assert_no_link_for "Create Ticket"
    end
    
    specify "Edit ticket link is shown if permission" do
      ticket
      define_permission user, "edit tickets", project
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    
    specify "Edit link isnt shown without permission" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end
    
    specify "Edit ticket link is shown if permission" do
      ticket
      define_permission user, "delete tickets", project
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
    
    specify "Edit link isnt shown without permission" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end
  end
  
  context "admin user" do
    before do
      sign_in_as admin
    end
    
    specify "can see new project link" do
      assert_link_for "New Project"
    end
    
    specify "can see edit project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end
    
    specify "can see delete project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end
    
    specify "Create ticket link is shown" do
      visit project_path(project)
      assert_link_for "Create Ticket"
    end
    
    specify "Edit ticket link is shown" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
    
    specify "Delete ticket link is shown" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
  end
end