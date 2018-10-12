def sign_in_as(email)
  visit "/"
  fill_in "Email", :with => email
  fill_in "Password", :with => "password"
  click_button "Log in"
end

def create_fixtures
  @admin_person = Person.create!(email_address: 'admin@abscond.org', first_name: 'Admin', last_name: 'Person')
  @roleholder_person = Person.create!(email_address: 'roleholder@abscond.org', first_name: 'Role', last_name: 'Holder')
  @admin = User.create!(email: 'admin@abscond.org', password: 'password', password_confirmation: 'password', role: 'admin', confirmed_at: Time.now)
  @roleholder = User.create!(email: 'roleholder@abscond.org', password: 'password', password_confirmation: 'password', role: '', confirmed_at: Time.now)
  @james1 = Person.create!(email_address: 'james@abscond.org', first_name: 'James', last_name: 'Darling')
  @james1_account = User.create!(email: 'james@abscond.org', password: 'password', password_confirmation: 'password', role: '', confirmed_at: Time.now)
  @james2 = Person.create!(first_name: 'James', last_name: 'Smith')
  @sarah = Person.create!(first_name: 'Sarah')
  @jon = Person.create!(first_name: 'Jon')
  @group1 = Group.create!(people: [@james1], users: [@roleholder])
  @group2 = Group.create!(people: [@james1, @jon], users: [@roleholder])
end
