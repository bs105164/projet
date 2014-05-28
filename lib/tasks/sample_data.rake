namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_chapitres
    make_scenes
    make_personnes
    make_anecdotes
    make_relationships
  end
end

def make_chapitres
  99.times do |n|
    name  = Faker::Name.name
    Chapitre.create!(name:     name)
  end
end

def make_scenes
  chapitres = Chapitre.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    periode = Faker::Lorem.sentence(5)
    title = Faker::Lorem.sentence(5)
    chapitres.each { |chapitre| chapitre.scenes.create!(content: content, periode: periode, title: title) }
  end
end

def make_anecdotes
  chapitres = Chapitre.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    sujet = Faker::Lorem.sentence(5)
    themes = Faker::Lorem.sentence(5)
    chapitres.each { |chapitre| chapitre.anecdotes.create!(content: content, sujet: sujet, themes: themes) }
  end
end

def make_personnes
  99.times do |n|
    name  = Faker::Name.name
    Personne.create!(name:     name)
  end
end

def make_relationships
  scenes = Scene.all
  personnes = Personne.all
  scene = scenes.first
  follower_scene = scenes[2..50]
  followed_personne = personnes[3..40]
  follower_scene.each { |follower| follower.appartient!(scene) }
  followed_personne.each      { |followed| scene.appartient!(followed) }
end
