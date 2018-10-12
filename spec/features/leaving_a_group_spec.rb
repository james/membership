require "rails_helper"

RSpec.feature "Leaving a group", :type => :feature do
  before do
    create_fixtures
  end

  context "as member" do
    before do
      sign_in_as("james@abscond.org")
    end
    scenario "leaving a leavable group" do
      group = Group.create!(name: 'Leavable', leavable: true)
      group.people << @james1
      visit groups_path
      click_link "Leavable"
      click_button "Leave"
      expect(page).to have_content("You have left Leavable")
    end

    scenario "trying to leave a non-leavable group" do
      group = Group.create!(name: 'Unleavable', leavable: false)
      group.people << @james1
      visit groups_path
      click_link "Unleavable"
      expect(page).to_not have_button("Leave")
    end
  end
end
