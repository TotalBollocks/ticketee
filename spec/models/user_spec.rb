require 'spec_helper'

describe User do
  describe "passwords" do
    it "needs password and confrmation to save" do
      u = User.new name: "steve"
      u.save
      expect(u).to_not be_valid
      
      u.password = "secret"
      u.save
      expect(u).to_not be_valid
      
      u.password_confirmation = "secret"
      u.save
      expect(u).to be_valid
    end
    
    it "needs password and confirmation to be same" do
      u = User.create name: "steve", password: "secret", password_confirmation: "not_same"
      expect(u).to_not be_valid
    end
  end
  
  describe "authentication" do
    let(:user) {User.create name: "Bob", password: "secret", password_confirmation: "secret"}
    
    it "authenticates with correct password" do
      expect(user.authenticate("secret")).to be_truthy
    end
    
    it "doesnt authenticate with incorrect password" do
      expect(user.authenticate("wrong")).to be_falsey
    end
  end
end
