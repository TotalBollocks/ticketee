require 'spec_helper'

# feature "Deleting tags" do
#   let!(:user) {create :user}
#   let!(:project) {create :project}
#   let!(:ticket) {create :ticket, project: project, tag_names: "dead-tag"}
  
#   before do
#     define_permission user, "view", project
#     define_permission user, "tag", project
#     sign_in_as user
#     click_link project.name
#     click_link ticket.title
#   end
  
#   scenario "Deleting tags", js: true do
#     skip # Cant get web driver to work..
#     click_link "delete-dead-tag"
#     expect(page).to_not have_content "dead-tag"
#   end
# end