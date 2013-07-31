require 'sequel'

module Chaindrive
  class Gear < Sequel::Model
    set_primary_key [:name, :version]

    class Entity < Grape::Entity
      expose :name
      expose :version
      expose :repository
      expose :created_at
    end
  end
end
