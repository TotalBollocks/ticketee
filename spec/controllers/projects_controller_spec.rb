require 'spec_helper'

describe ProjectsController do
  let(:user) {create :user}
  
  it "should display error for missing project" do
    get :show, id: "non-existent"
    expect(response).to redirect_to projects_path
    expect(flash[:alert]).to eq "The project you were looking for could not be found"
  end
  
  context "standard users" do
    actions = {
      new: :get,
      create: :post,
      edit: :get,
      update: :patch,
      destroy: :delete
      }
    
    before do
      sign_in user
    end
    
    actions.each do |action, method|
      it "cant access the #{action} action" do
        sign_in user
        send(method, action, id: create(:project))
        
        expect(response).to redirect_to '/'
        expect(flash[:alert]).to eq "You must be an admin to do that"
      end
    end
  end
end
