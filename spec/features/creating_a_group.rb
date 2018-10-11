require "rails_helper"

RSpec.feature "Filtering", :type => :feature do
  before do
    create_fixtures
  end

  context "as admin" do
    before do
      sign_in_as("admin@abscond.org")
    end
    scenario "with no filter, joinable, leavable" do
      visit new_group_path
      fill_in "Name", with: "Environment Group"
      fill_in "Description", with: "A group dedicated to saving the environment"
      fill_in "Why receiving", with: "you joined the Environment Group"
      check "Joinable"
      check "Leavable"
      select @roleholder.email, from: 'User'
      fill_in "Role", with: 'Chairperson'
      check "Can manage members"
      check "Is public"
      check "Can manage group"
      click_button "Create Group"
      expect(page).to have_content("Environment Group")
      expect(page).to have_content("0 Members")
      expect(page).to have_content("A group dedicated to saving the environment")
      expect(page).to have_content("Role Holder: Chairperson")
    end
  end
end
