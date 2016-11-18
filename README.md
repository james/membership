A membership database for federated non profits
===============================================

The problem
-----------

For large, mainly volunteer run non profits, managing personal data can be difficult.

This project aims to allows a HQ to securely share the personal data of members with group leaders, while allowing members to understand who is contacting them and why, and to manage those relationships.

Setup
-----

You will need ruby and postgres with postgis installed locally. For ruby I recommend rvm or rbenv, and postgres and postgis using postgres.app on OSX

Clone, `bundle`, `rake db:setup`, `rails server` should get you going.

Concept outline
---------------

Admins are able to filter members to their liking. Once they have created a filter, they can create a 'group' for that filter, and assign role holders to that group. Role holders will only be able to see and message members who are within groups they hold a role.

Seeding fake data
-----------------

You can run `rake import_fake` to fill the database with 10,000 fake profiles to test the system out. To create the first admin user, sign up via the application, then run `rails console; u = User.first; u.role = 'admin'; u.save!`.

Nationbuilder Migration
-----------------------

This app can import data from a nationbuilder database dump.

If you follow [these steps](http://nationbuilder.com/ht_open_your_snapshot) precisely to load your dump into your local postgres installation, and change the table_name_prefix in `app/models/nationbuilder.rb` then you should be able to import data by running `rake import`

Testing
-------

I'm currently working on this quite quickly, and more tests could definitely be written.

For now, I am focussing on rspec feature tests, which can be found in spec/features and run by running `rake`
