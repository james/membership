require "rails_helper"

RSpec.feature "Joining a group", :type => :feature do
  before do
    create_fixtures
  end

  context "as member" do
    before do
      sign_in_as("james@abscond.org")
    end
    scenario "joining a joinable group" do
      Group.create!(name: 'Joinable', joinable: true)
      visit groups_path
      click_link "Joinable"
      click_button "Join"
      expect(page).to have_content("You are now a member of Joinable")
    end

    scenario "trying to join a non-joinable group" do
      Group.create!(name: 'Unjoinable', joinable: false)
      visit groups_path
      click_link "Unjoinable"
      expect(page).to_not have_button("Join")
    end
  end
end
