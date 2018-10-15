require "rails_helper"

RSpec.feature "Managing group memberships", :type => :feature do
  before do
    create_fixtures
  end

  context "as admin" do
    before do
      sign_in_as("admin@abscond.org")
      visit group_path(@group1)
      click_link 'Manage members'
    end
    scenario "can see correct members" do
      within('.group_members') do
        expect(page).to have_content('Darling')
        expect(page).to_not have_content('Smith')
      end
    end
    scenario "can add a member" do
      select 'James Smith', from: 'Add a member'
      click_button 'Add'
      within('.group_members') do
        expect(page).to have_content('Smith')
      end
    end

    scenario "can remove member" do
      click_link 'Remove'
      within('.group_members') do
        expect(page).to_not have_content('Darling')
      end
    end
  end

  scenario "as member" do
    sign_in_as("roleholder@abscond.org")
    visit group_path(@group1)
    expect(page).to_not have_link('Manage members')
    visit group_group_memberships_path(@group1)
    expect(page.status_code).to eq(403)
  end

end
