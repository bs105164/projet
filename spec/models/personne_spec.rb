require 'spec_helper'

describe Personne do
    before do
    @personne = Personne.new(name: "Chapitre exemple")
  end

  subject { @personne }

  it { should respond_to(:name) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:scenes) }
  it { should respond_to(:appartient?) }
  it { should respond_to(:appartient!) }
  it { should respond_to(:desappartient!) }
  it { should be_valid }

  describe "when name is not present" do
      before { @personne.name = " " }
      it { should_not be_valid }
  end
  
  describe "when name is too long" do
      before { @personne.name = "a"*251 }
      it { should_not be_valid }
  end
  
   describe "appartient" do
     let(:chapitre) { FactoryGirl.create(:chapitre) }
     let!(:scene) { FactoryGirl.create(:scene, chapitre: chapitre) }
     before do
	chapitre.save
        scene.save
        @personne.save
        scene.appartient!(@personne)
     end
        it { should be_appartient(scene) }
        its(:scenes) { should include(scene) }
     describe "et desapartient" do
	before { @personne.desappartient!(scene) }
        
        it { should_not be_appartient(scene) }
        its(:scenes) { should_not include(scene) } 
     end
  end
end
