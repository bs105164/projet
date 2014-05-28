class Chapitre < ActiveRecord::Base
  attr_accessible :name
  has_many :scenes, dependent: :destroy
  has_many :anecdotes, dependent: :destroy
  validates :name, presence: true, length: { maximum: 250 }
end
