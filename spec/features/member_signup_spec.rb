require "rails_helper"

RSpec.feature "Registering a new organisation", :type => :feature do
  scenario "successfully when person not in DB" do
    visit '/users/sign_up'
    fill_in 'Email', with: 'member@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Member'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Phone', with: '077777777'
    click_button 'Sign up'
    expect(page).to have_content('member@example.com')
    expect(page).to have_content('Member Smith')
  end

  scenario "successfully when person already in DB"

  scenario "unsuccessfully because user already exists"

  scenario "unsuccessfully because no password"
end
