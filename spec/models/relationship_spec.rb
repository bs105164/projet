require 'spec_helper'

describe Relationship do
  let(:scene) { FactoryGirl.create(:scene, chapitre: FactoryGirl.create(:chapitre)) }
  let(:personne) { FactoryGirl.create(:personne) }
  let(:relationship) { scene.relationships.build(personne_id: personne.id) }
  
  subject { relationship }
  
  it { should respond_to(:personne) }
  it { should respond_to(:scene) }
  its(:personne) { should == personne }
  its(:scene) { should == scene }
  it { should be_valid }

  describe "when personne id is not present" do
      before { relationship.personne_id = nil }
      it { should_not be_valid }
  end
 
  describe "when scene id is not present" do
      before { relationship.scene_id = nil }
      it { should_not be_valid }
  end
end
