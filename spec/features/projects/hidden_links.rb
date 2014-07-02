require 'spec_helper'

feature "Hidden links" do
  let(:user) {create :user}
  let(:admin) {create :admin}
  let(:project) {create :project}
  
  context "anonymous user" do
    specify "cannot see new project link" do
      visit '/'
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
  end
  
  context "Regular user" do
    before do
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
  end
end