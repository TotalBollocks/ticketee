require 'spec_helper'

describe TicketsController do
  let(:user) {create :user}
  let(:project) {create :project}
  let(:ticket) {create :ticket, project: project}
  
  context "Standard users" do
    it "cannot access tickets for restricted project" do
      sign_in user
      get :show, id: ticket, project_id: project
      
      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq "The project you were looking for could not be found"
    end
  end
  
  context "permission to view projects" do
    before do
      define_permission user, "view", project
      sign_in user
    end
    
    def cannot_create_tickets
      expect(response).to redirect_to project
      expect(flash[:alert]).to eq "You cannot create tickets on this project"
    end
    
    it "cant use new action" do
      get :new, project_id: project
      cannot_create_tickets
    end
    
    it "cant use create action" do
      post :new, project_id: project
      cannot_create_tickets
    end
    
    it "cant use destroy action" do
      delete :destroy, project_id: project, id: ticket
      expect(response).to redirect_to project
      expect(flash[:alert]).to eq "You cannot delete tickets on this project"
    end
  end
end
