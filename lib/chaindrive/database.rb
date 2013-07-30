require 'sinatra/sequel'

# Define the database tables that are initially needed for the application to properly
# function. In this particular case it is the `users` and `gears` tables.
migration "initial migration" do
  database.create_table! :users do
    set_primary_key :id
    column :name, String, :index => true, :null => false
  end
  
  database.create_table! :gears do
    set_primary_key [:name, :version], :name => 'PkGears'
    column :name, String, :index => true, :null => false
    column :version, String, :index => true, :null => false
    column :repository, String, :null => false
    column :status, Boolean, :null => false, :default => true
    foreign_key :user_id, :users, :key => :id
  end
end
