require 'spec_helper'

describe Admin::UsersController do
  let(:user) {create :user}
  
  context "standard user" do
    before { sign_in user }
    
    it "cant access index action" do
      get :index
      
      expect(response).to redirect_to '/'
      expect(flash[:alert]).to eq "You must be an admin to do that"
    end
  end
end
