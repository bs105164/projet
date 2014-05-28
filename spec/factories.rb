FactoryGirl.define do
  factory :chapitre do
    sequence(:name) { |n| "Chapitre #{n}"}
  end

  factory :scene do
    sequence(:title) { |n| "Scene #{n}"}
    content "Lorem ipsum"
    sequence(:periode) { |n| "Periode #{n}"}
    chapitre
  end

  factory :anecdote do
    sequence(:sujet) { |n| "Anecdote #{n}"}
    content "Lorem ipsum"
    themes "Lorem ipsum"
    chapitre
  end
 
  factory :personne do
    sequence(:name) { |n| "Personnage #{n}"}
  end
end
