require 'spec_helper'

describe CommentsController do
  let(:user) {create :user}
  let(:project) {create :project}
  let(:ticket) {create :ticket, project: project}
  let(:state) {create :state, name: "New"}
  
  context "user without permission cant change state" do
    before {sign_in user}
    
    it "cant pass state_id" do
      post :create, { comment: {  text: "Hacked", state_id: state.id}, ticket_id: ticket.id }
      ticket.reload
      expect(ticket.state).to be_nil
    end
  end
  
  context "user without permission to tag a ticket" do
    before {sign_in user}
    
    it "cant tag ticket when creating commnt" do
      post :create, { comment: {text: "Tag!", tag_names: "one two"}, ticket_id: ticket.id }
      ticket.reload
      expect(ticket.tags).to be_empty
    end
  end
end
