class Relationship < ActiveRecord::Base
    attr_accessible :personne_id, :scene_id
    belongs_to :personne
    belongs_to :scene
    validates :personne, presence: :true
    validates :scene, presence: :true
end
