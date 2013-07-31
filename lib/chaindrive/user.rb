require 'sequel'

module Chaindrive
  class User < Sequel::Model
    def exists?(name)
      super.find(:name => name).exists?
    end

    class Entity < Grape::Entity
      expose :name
    end
  end
end
