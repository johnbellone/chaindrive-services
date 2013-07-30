require 'sequel'

module Chaindrive
  class Gear < Sequel::Model
    primary_key [:name, :version]
  end
end
