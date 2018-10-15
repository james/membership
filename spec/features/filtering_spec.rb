require "rails_helper"

RSpec.feature "Filtering", :type => :feature do
  before do
    create_fixtures
  end

  context "as admin" do
    before do
      sign_in_as("admin@abscond.org")
    end
    scenario "blank filter" do
      visit members_path
      expect(page).to have_text("James")
      expect(page).to have_text("Sarah")
      expect(page).to have_text("Jon")
    end

    scenario "filter by first name" do
      visit members_path
      fill_in "First Name", :with => "James"
      click_button "Filter"

      expect(page).to have_text("James")
      expect(page).to_not have_text("Sarah")
      expect(page).to_not have_text("Jon")
    end
  end

  context "as member" do
    before do
      sign_in_as("james@abscond.org")
    end

    scenario "Trying to view profile" do
      visit member_path(@sarah)
      expect(page.status_code).to eq(403)
    end

    scenario "Trying to create new group" do
      visit new_group_path
      expect(page.status_code).to eq(403)
    end
  end
end
