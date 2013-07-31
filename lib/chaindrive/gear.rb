require 'sequel'

module Chaindrive
  class Gear < Sequel::Model
    set_primary_key [:name, :version]
  end
end
