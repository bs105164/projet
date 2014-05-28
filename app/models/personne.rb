class Personne < ActiveRecord::Base
   attr_accessible :name
   has_many :reverse_relationships, foreign_key: "personne_id", class_name: "Relationship", dependent: :destroy
   has_many :scenes, through: :reverse_relationships, source: :scene 
   validates :name, presence: true, length: { maximum: 250 }
   
   def appartient?(scene)
       reverse_relationships.find_by(scene: scene)
   end
 
   def appartient!(scene)
       reverse_relationships.create!(scene: scene)
   end
   
   def desappartient!(scene)
       reverse_relationships.find_by(scene: scene).destroy
   end
end
