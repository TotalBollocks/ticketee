require 'spec_helper'

describe FilesController do
  let(:good_user) {create :user}
  let(:bad_user) {create :user}
  let(:project) {create :project}
  let(:ticket) {create :ticket, project: project, user: good_user}
  let(:path) {Rails.root + "spec/files/text.txt"}
  let(:asset) {ticket.assets.create asset: File.open(path)}
  
  before do
    good_user.permissions.create! action: "view", thing: project
  end
  
  context "user with access" do
    before do
      sign_in good_user
    end
    
    it "can access assets in project" do
      get :show, id: asset
      expect(response.body).to eq  File.read(path)
    end
  end
    
  context "user without access" do
    before do
      sign_in bad_user
    end
    
    it "cant access assets in project" do
      get :show, id: asset
      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq "The asset you were looking for could not be found"
    end
  end
end
