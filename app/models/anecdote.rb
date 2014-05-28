class Anecdote < ActiveRecord::Base
   attr_accessible :content, :sujet, :themes
   belongs_to :chapitre
   validates :sujet, presence: true, length: { maximum: 250 }
   validates :content, presence: true
   validates :themes, presence: true, length: { maximum: 250 }
end
