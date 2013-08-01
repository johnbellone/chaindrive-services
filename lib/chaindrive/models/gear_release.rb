module Chaindrive
  class GearRelease < Sequel::Model
    many_to_one :gear
    set_primary_key [:gear_id, :version]

    def hit!
      super.hits += 1
      super.save!(:validate => false)
    end

    class Entity < Grape::Entity
      expose :version
      expose :hits
      expose :created_at, :updated_at
    end

  end
end
