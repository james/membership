require "rails_helper"

RSpec.feature "Filtering", :type => :feature do
  before do
    create_fixtures
    sign_in_as("roleholder@abscond.org")
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
