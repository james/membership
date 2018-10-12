task :import => :environment do
  GroupMembership.delete_all
  Member.delete_all
  Nationbuilder::Signup.find_each do |signup|
    member = Member.new
    [
      "first_name",
      "last_name",
      ["email1", "email_address"],
      "email_opt_in",
      "is_volunteer",
      "phone",
      "mobile",
      "mobile_opt_in",
      "employer",
      "occupation",
      ["facebook_uid", "facebook_id"],
      "twitter_login",
      "born_at",
      "created_at",
      "updated_at"
    ].each do |att|
      if att.is_a?(Array)
        member.send("#{att[1]}=", signup.send(att[0]))
      else
        member.send("#{att}=", signup.send(att))
      end
    end

    ## Add nationbuiler custom values you want to import below
    # member.membership_id = signup.custom_values["membership_number"]
    # member.membership_started_at = Time.at(signup.custom_values["joined_date"].to_i) if signup.custom_values["joined_date"]
    # member.membership_level = signup.custom_values["membership_type"]
    # member.paypal_id = signup.custom_values["paypal_id"]

    if signup.address
      [
        "address1",
        "address2",
        "city",
        "state",
        "country_code",
        ["zip", "post_code"],
        "lat",
        "lng"
      ].each do |att|
        if att.is_a?(Array)
          member.send("#{att[1]}=", signup.address.send(att[0]))
        else
          member.send("#{att}=", signup.address.send(att))
        end
      end
      member.lonlat = "POINT(#{signup.address.lng} #{signup.address.lat})"
    end

    member.save!
    p "#{member.id}: #{member.first_name} #{member.last_name}"
  end
end

task :import_fake => :environment do
  require 'csv'
  addresses = CSV.read("lib/tasks/addresses.csv").to_a
  Faker::Config.locale = 'en-GB'
  GroupMembership.delete_all
  Member.delete_all
  10000.times do
    address = addresses.sample
    Member.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email_address: Faker::Internet.email,
      email_opt_in: Faker::Boolean.boolean,
      is_volunteer: Faker::Boolean.boolean,
      phone: Faker::PhoneNumber.phone_number,
      mobile: Faker::PhoneNumber.cell_phone,
      mobile_opt_in: Faker::Boolean.boolean,
      employer: Faker::Company.name,
      occupation: Faker::Company.profession,
      facebook_id: nil,
      twitter_login: nil,
      born_at: Faker::Date.between(80.years.ago, 16.years.ago),
      address1: "#{address[2]} #{address[3]}",
      address2: address[4],
      city: address[5],
      state: address[8],
      country_code: "GB",
      post_code: address[9],
      lat: address[0],
      lng: address[1],
      lonlat: "POINT(#{address[1]} #{address[0]})",
      membership_id: (Faker::Code.isbn if Faker::Boolean.boolean),
      membership_started_at: Faker::Date.between(Date.today, 1.year.ago),
      membership_level: Faker::Number.between(1, 100),
      paypal_id: Faker::Code.isbn
    )
  end
end
