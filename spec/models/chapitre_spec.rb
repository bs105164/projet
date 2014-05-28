require 'spec_helper'

describe Chapitre do
  before do
    @chapitre = Chapitre.new(name: "Chapitre exemple")
  end

  subject { @chapitre }
  it { should respond_to(:name) }
  it { should respond_to(:scenes) }
  it { should respond_to(:anecdotes) }
  it { should be_valid }

  describe "when name is not present" do
      before { @chapitre.name = " " }
      it { should_not be_valid }
  end
  
  describe "when name is too long" do
      before { @chapitre.name = "a"*251 }
      it { should_not be_valid }
  end
  
  describe "have the right order" do
       let!(:older_chapter) do
     	 FactoryGirl.create(:chapitre, created_at: 1.day.ago)
   	 end
       let!(:newer_chapter) do
     	 FactoryGirl.create(:chapitre, created_at: 1.hour.ago)
   	 end
       before do
          older_chapter.save
          newer_chapter.save
       end
       it "should have the right scenes in the right order" do
         expect(Chapitre.all.to_a).to eq [older_chapter, newer_chapter]
       end
  end
  
  describe "scene associations" do

    before { @chapitre.save }
    let!(:older_scene) do
      FactoryGirl.create(:scene, chapitre: @chapitre, created_at: 1.day.ago)
    end
    let!(:newer_scene) do
      FactoryGirl.create(:scene, chapitre: @chapitre, created_at: 1.hour.ago)
    end

    it "should have the right scenes in the right order" do
      expect(@chapitre.scenes.to_a).to eq [older_scene, newer_scene]
    end

    it "should destroy associated scenes" do
      scenes = @chapitre.scenes.to_a
      @chapitre.destroy
      expect(scenes).not_to be_empty
      scenes.each do |scene|
        expect(Scene.where(id: scene.id)).to be_empty
      end
    end
  end
  describe "anecdote associations" do

    before { @chapitre.save }
    let!(:older_anecdote) do
      FactoryGirl.create(:anecdote, chapitre: @chapitre, created_at: 1.day.ago)
    end
    let!(:newer_anecdote) do
      FactoryGirl.create(:anecdote, chapitre: @chapitre, created_at: 1.hour.ago)
    end

    it "should have the right anecdote in the right order" do
      expect(@chapitre.anecdotes.to_a).to eq [older_anecdote, newer_anecdote]
    end

    it "should destroy associated anecdotes" do
      anecdotes = @chapitre.anecdotes.to_a
      @chapitre.destroy
      expect(anecdotes).not_to be_empty
      anecdotes.each do |anecdote|
        expect(Anecdote.where(id: anecdote.id)).to be_empty
      end
    end
  end
end
