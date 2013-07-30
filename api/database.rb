require 'sequel'

Sequel::Model.plugin(:schema)

# Define the database table which represents the users that have registered
# through Omniauth and wish to add a Gear to the registry.
DB.create_table? :users do
  set_primary_key :id
  column :name, String, :index => true, :null => false
end

# Define the database table which represents the Gears that have been registered
# through GitHub (or by other means) callbacks.
DB.create_table? :gears do
  set_primary_key [:name, :version], :name => 'PkGears'
  column :name, String, :index => true, :null => false
  column :version, String, :index => true, :null => false
  column :repository, String, :null => false
  column :status, Boolean, :null => false, :default => true
  foreign_key :user_id, :users, :key => :id
end
