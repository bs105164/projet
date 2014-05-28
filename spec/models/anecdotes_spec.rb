require 'spec_helper'

describe Anecdote do
   let(:chapitre) { FactoryGirl.create(:chapitre) }
  before do
     @anecdote = chapitre.anecdotes.build(sujet: "test scene", content: "Lorem ipsum", themes: "ecologie, nature")
  end
 
  subject { @anecdote }

  it { should respond_to(:content) }
  it { should respond_to(:sujet) }
  it { should respond_to(:themes) }
  it { should respond_to(:chapitre_id) }
  it { should respond_to(:chapitre) }
  its(:chapitre) { should eq chapitre }

  it { should be_valid }

  describe "when its not valid" do
    describe "when sujet is not present" do
      before { @anecdote.sujet = nil }
      it { should_not be_valid }
    end
    describe "when sujet is too long" do
      before { @anecdote.sujet = "a" * 251 }
      it { should_not be_valid }
    end
    describe "when content is not present" do
      before { @anecdote.content = nil }
      it { should_not be_valid }
    end
    describe "when periode is not present" do
      before { @anecdote.themes = nil }
      it { should_not be_valid }
    end
  end
end
