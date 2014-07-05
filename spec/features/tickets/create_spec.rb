require 'spec_helper'

feature "Creating tickets" do
  let(:user) {create :user}
  let(:project) {create :project}
  
  before do
    define_permission user, "view", project
    define_permission user, "create tickets", project
    sign_in_as user
    
    click_link project.name
    click_link "Create Ticket"
  end
  
  scenario "creating a ticket" do
    fill_in "Title", with: "Bad project"
    fill_in "Description", with: "So so baaaaaaaaad"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has been created"
    within '#ticket #author' do
      expect(page).to have_content user.email
    end
  end
  
  scenario "creating ticket with invalid attributes" do
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end
  
  scenario "where description is less than 10 chars" do
    fill_in "Title", with: "Internet Explorer"
    fill_in "Description", with: "Sucks"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Description is too short"
  end
  
  scenario "Creating ticket with attachment" do
    fill_in "Title", with: "Im the best"
    fill_in "Description", with: "That ever waaaas"
    attach_file "File #1", "spec/files/text.txt"
    attach_file "File #2", "spec/files/text2.txt"
    attach_file "File #3", "spec/files/text3.txt"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has been created"
    within "#ticket .assets" do  
      expect(page).to have_content "text.txt"
      expect(page).to have_content "text2.txt"
      expect(page).to have_content "text3.txt"
    end
  end
end