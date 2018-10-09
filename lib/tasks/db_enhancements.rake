namespace :db do
  desc 'Creates shared_extensions Schema and enables postgis extension'
  task extensions: :environment do
    # drop PostGIS extension from public schema;
    ActiveRecord::Base.connection.execute 'DROP EXTENSION IF EXISTS postgis;'
    # Create Schema
    ActiveRecord::Base.connection.execute 'CREATE SCHEMA IF NOT EXISTS shared_extensions;'
    # Enable PostGIS
    ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS postgis SCHEMA shared_extensions;'
    # Grant usage to public
    ActiveRecord::Base.connection.execute 'GRANT usage ON SCHEMA shared_extensions to public;'
  end
end

Rake::Task['db:create'].enhance do
  Rake::Task['db:extensions'].invoke
end

Rake::Task['db:test:purge'].enhance do
  Rake::Task['db:extensions'].invoke
end
