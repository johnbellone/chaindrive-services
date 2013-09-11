# coding: utf-8
require 'sinatra/sequel'

# Setup the database connection using the environment string. This makes us
# agnostic from a single database adapter and works out of the box with Heroku.
set :database, ENV['DATABASE_URL']

# Define the database tables that are initially needed for the application to
# properly function. In this particular case it is the `users` and `gears`.
migration "initial migration" do
  database.create_table! :gears do
    primary_key :id
    column :name, String, :index => true, :null => false, :unique => true
    column :owner, String, :index => true, :null => false
    column :url, String, :null => false, :unique => true
    column :description, String
    column :homepage, String
    column :created_at, DateTime, :null => false, :index => true
    column :updated_at, DateTime, :null => false, :index => true
  end

  database.create_table! :gear_releases do
    primary_key [:gear_id, :version], :name => 'PkGearRelease'
    foreign_key :gear_id
    column :version, String, :index => true, :null => false
    column :hits, Integer, :null => false, :default => 0
    column :created_at, DateTime, :null => false, :index => true
    column :updated_at, DateTime, null: false, index: true
  end
end

