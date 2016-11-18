require "rails_helper"

RSpec.feature "Filtering", :type => :feature do
  before do
    create_fixtures
    sign_in_as("roleholder@abscond.org")
  end

  scenario "Trying to view profile" do
    assert_raises(ActiveRecord::RecordNotFound) do
      visit person_path(@sarah)
    end
  end

  scenario "Trying to view group" do
    assert_raises(ActiveRecord::RecordNotFound) do
      visit group_path(Group.create!)
    end
  end

  scenario "Trying to create new group" do
    visit new_group_path
    expect(page.status_code).to eq(403)
  end

  scenario "Trying to view group users" do
    visit group_group_users_path(Group.create!)
    expect(page.status_code).to eq(403)
  end
end
