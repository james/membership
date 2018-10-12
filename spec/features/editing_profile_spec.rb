RSpec.feature "Editing profile", :type => :feature do
  before do
    create_fixtures
  end

  context "as member" do
    before do
      sign_in_as("james@abscond.org")
    end
    scenario "successfully" do
      visit '/'
      click_link "Edit your profile"
      fill_in "First name", with: 'New'
      fill_in "Last name", with: 'Name'
      click_button "Save details"
      expect(page).to have_content("New Name")
    end
  end
end
