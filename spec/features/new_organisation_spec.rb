require "rails_helper"

RSpec.feature "Registering a new organisation", :type => :feature do
  before do
    Capybara.app_host = "http://lvh.me"
    Apartment::Tenant.switch! 'public'
  end

  after do
    Capybara.app_host = "http://app.lvh.me"
    Apartment::Tenant.switch! 'app'
  end
  
  scenario "successfully" do
    visit "/"
    fill_in "Name", with: 'New Organisation'
    fill_in "Subdomain", with: 'new-organisation'
    click_button "Create Organisation"
    expect(current_url).to eq('http://new-organisation.lvh.me/organisation/setup')
    expect(page).to have_content("Welcome to New Organisation")
  end

  scenario "with invalid info" do
    visit "/"
    fill_in "Name", with: ''
    fill_in "Subdomain", with: '%$£%'
    click_button "Create Organisation"
    expect(current_url).to eq('http://lvh.me/organisations')
    expect(page).to have_content("can't be blank")
    expect(page).to have_content("contains invalid characters")
  end
end
