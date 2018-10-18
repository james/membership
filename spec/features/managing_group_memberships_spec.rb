require "rails_helper"

RSpec.feature "Managing group memberships", :type => :feature do
  before do
    @roleholder = create(:member, email_address: 'roleholder@example.com', first_name: 'Role', last_name: 'Holder')
    @roleholder_account = create(:user, email: 'roleholder@example.com', role: '')
    @member = create(:member, email_address: 'member@example.com', first_name: 'Normal', last_name: 'Member')
    @member_account = create(:user, email: 'member@example.com', role: '')
    @not_member = create(:member, first_name: 'Not', last_name: 'Member')
    @group = create(:group)
    @normal_membership = create(:group_membership, member: @member, group: @group)
    @roleholding = create(:group_membership, member: @roleholder, group: @group, roleholder: true, role_name: 'Chair', can_manage_members: true, is_public: true, can_manage_group: true)
  end

  context "as admin" do
    before do
      sign_in_as("admin@example.com")
      visit group_path(@group)
      click_link 'Manage members'
    end
    scenario "can see correct members" do
      within('.group_members') do
        expect(page).to have_content('Normal')
        expect(page).to_not have_content('Not')
      end
    end
    scenario "can add a member" do
      select 'Not Member', from: 'Add a member'
      click_button 'Add'
      within('.group_members') do
        expect(page).to have_content('Not')
      end
    end
    scenario "can remove member" do
      within('.group_members') do
        expect(page).to have_content('Normal')
      end
      click_link 'Remove', :match => :first
      within('.group_members') do
        expect(page).to_not have_content('Normal')
      end
    end
    scenario "can make member a roleholder" do
      within('.group_members') do
        click_link 'Make roleholder'
      end
      check 'Is roleholder'
      fill_in 'Role name', with: 'Chair'
      check 'Can manage members'
      check 'Is public'
      check 'Can manage group'
      click_button 'Save'
      within('.group_members') do
        expect(page).to have_content('Chair')
      end
    end
  end

  context "as roleholder with all permissions" do
    before do
      sign_in_as("roleholder@example.com")
      visit group_path(@group)
      click_link 'Manage members'
    end

    scenario "can see correct members" do
      within('.group_members') do
        expect(page).to have_content('Normal')
        expect(page).to_not have_content('Not')
      end
    end
    scenario "cannot add a member" do
      expect(page).to_not have_button('Save')
    end
    scenario "can remove member" do
      within('.group_members') do
        expect(page).to have_content('Normal')
      end
      click_link 'Remove', :match => :first
      within('.group_members') do
        expect(page).to_not have_content('Normal')
      end
    end
    scenario "can make member a roleholder" do
      within('.group_members') do
        click_link 'Make roleholder'
      end
      check 'Is roleholder'
      fill_in 'Role name', with: 'Chair'
      check 'Can manage members'
      check 'Is public'
      check 'Can manage group'
      click_button 'Save'
      within('.group_members') do
        expect(page).to have_content('Chair')
      end
    end
  end

  scenario "as member" do
    sign_in_as("member@example.com")
    visit group_path(@group)
    expect(page).to_not have_link('Manage members')
    expect(page).to_not have_link('Remove')
    visit group_group_memberships_path(@group)
    expect(page.status_code).to eq(403)
    visit edit_group_group_membership_path(@group, @member)
    expect(page.status_code).to eq(403)
  end

end
