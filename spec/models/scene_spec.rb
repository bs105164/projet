require 'spec_helper'

describe Scene do
  let(:chapitre) { FactoryGirl.create(:chapitre) }
  before do
     @scene = chapitre.scenes.build(title: "test scene", content: "Lorem ipsum", periode:"12h")
  end
 
  subject { @scene }

  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:periode) }
  it { should respond_to(:chapitre_id) }
  it { should respond_to(:chapitre) }
  it { should respond_to(:relationships) }
  it { should respond_to(:personnes) }
  it { should respond_to(:appartient?) }
  it { should respond_to(:appartient!) }
  it { should respond_to(:desappartient!) }
  its(:chapitre) { should eq chapitre }

  it { should be_valid }

  describe "when its not valid" do
    describe "when title is not present" do
      before { @scene.title = nil }
      it { should_not be_valid }
    end
    describe "when title is too long" do
      before { @scene.title = "a" * 251 }
      it { should_not be_valid }
    end
    describe "when content is not present" do
      before { @scene.content = nil }
      it { should_not be_valid }
    end
    describe "when periode is not present" do
      before { @scene.periode = nil }
      it { should_not be_valid }
    end
    describe "when periode is too long" do
      before { @scene.periode = "a" * 251 }
      it { should_not be_valid }
    end
  end
    describe "appartient" do
     let(:personne) { FactoryGirl.create(:personne) }
     before do
	chapitre.save
        @scene.save
        personne.save
        @scene.appartient!(personne)
     end
        it { should be_appartient(personne) }
        its(:personnes) { should include(personne) }
     describe "et desapartient" do
	before { @scene.desappartient!(personne) }
        
        it { should_not be_appartient(personne) }
        its(:personnes) { should_not include(personne) } 
     end
  end
end
