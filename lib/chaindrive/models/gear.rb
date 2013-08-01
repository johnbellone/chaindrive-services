require 'sequel'

module Chaindrive
  class Gear < Sequel::Model
    one_to_many :gear_releases
    set_primary_key :id

    def hits
      gear_releases.sum(:hits)
    end

    def self.exists?(name)
      super.find(:name => name).exists?
    end

    class Entity < Grape::Entity
      expose :name
      expose :owner
      expose :repository
      expose :hits
      expose :homepage
      expose :created_at, :updated_at
    end
  end
end
