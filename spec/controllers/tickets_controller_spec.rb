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
end
