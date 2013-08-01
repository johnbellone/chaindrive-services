require 'sequel'

module Chaindrive
  class Gear < Sequel::Model
    set_primary_key [:name, :version]

    def hits!
      self.hits += 1
      self.save(:validate => false)
    end

    def exists?(name)
      super.find(:name => name).exists?
    end

    class Entity < Grape::Entity
      expose :name
      expose :version
      expose :repository
      expose :hits
      expose :created_at
    end
  end
end
