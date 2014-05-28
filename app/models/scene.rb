class Scene < ActiveRecord::Base
   attr_accessible :content, :title, :periode
   has_many :relationships, foreign_key: "scene_id", dependent: :destroy
   has_many :personnes, through: :relationships, source: :personne 
   belongs_to :chapitre
   validates :title, presence: true, length: { maximum: 250 }
   validates :content, presence: true
   validates :periode, presence: true, length: { maximum: 250 }
   
   def appartient?(personnage)
       relationships.find_by(personne_id: personnage.id)
   end
   
   def appartient!(personnage)
       relationships.create!(personne_id: personnage.id)
   end
   
   def desappartient!(personnage)
       relationships.find_by(personne_id: personnage.id).destroy
   end


end
