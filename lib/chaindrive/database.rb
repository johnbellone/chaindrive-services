require 'sinatra/sequel'

# Setup the database connection using the environment string. This makes us agnostic
# from a single database adapter and works out of the box with Heroku.
set :database, ENV['DATABASE_URL']

# Define the database tables that are initially needed for the application to properly
# function. In this particular case it is the `users` and `gears` tables.
migration "initial migration" do
  database.create_table! :users do
    primary_key :id
    column :name, String, :index => true, :null => false
  end
  
  database.create_table! :gears do
    primary_key [:name, :version], :name => 'PkGears'
    column :name, String, :index => true, :null => false
    column :version, String, :index => true, :null => false
    column :repository, String, :null => false
    column :status, TrueClass, :null => false, :default => true
    column :created_at, DateTime, :null => false, :index => true
    foreign_key :user_id, :users, :key => :id
  end
end

migration "add hits to gear" do
  database.alter_table :gears do
    add_column :hits, Integer, :null => false, :default => 0
  end
end
