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
end
