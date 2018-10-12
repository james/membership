require "rails_helper"

RSpec.feature "Registering a new organisation", :type => :feature do
  scenario "successfully when person not in DB" do
    visit '/users/sign_up'
    fill_in 'Email', with: 'member@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('We have emailed you a confirmation email')
    visit('/users/confirmation?confirmation_token=' + User.last.confirmation_token)
    expect(page).to have_content('member@example.com')
    expect(page).to_not have_content('You are already a member.')
    fill_in 'First name', with: 'Member'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Phone', with: '077777777'
    click_button 'Save details'
    expect(page).to have_content('Member Smith')
  end

  scenario "successfully when person already in DB" do
    Person.create!(email_address: 'member@example.com', first_name: 'Member', last_name: 'Smith', phone: '0777')
    visit '/users/sign_up'
    fill_in 'Email', with: 'member@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('We have emailed you a confirmation email')
    visit('/users/confirmation?confirmation_token=' + User.last.confirmation_token)
    expect(page).to have_content('Member Smith')
    expect(page).to have_content('You are already a member.')
  end

  scenario "unsuccessfully because user already exists" do
    User.create!(email: 'member@example.com', password: 'password', password_confirmation: 'password')
    visit '/users/sign_up'
    fill_in 'Email', with: 'member@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('has already been taken')
  end

  scenario "unsuccessfully because no password" do
    visit '/users/sign_up'
    fill_in 'Email', with: 'member@example.com'
    click_button 'Sign up'
    expect(page).to have_content('can\'t be blank')
  end
end
