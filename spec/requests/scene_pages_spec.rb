require 'spec_helper'

describe "ScenePages" do
  subject { page }
  let(:chapitre) { FactoryGirl.create(:chapitre) }
  before { chapitre.save }
  describe "new" do
     before do
           visit newscene_path(chapitre)
        end
     describe "pages" do
       it { should have_selector('h1', text: "Creation Scene") }
       it { should have_selector('title', text: "Creation Scene") }
     end
     describe "form" do
	
            describe "with invalid information" do

        it "should not create a scene" do
          expect { click_button "Ajouter" }.not_to change(Scene, :count)
        end

        describe "error messages" do
          before { click_button "Ajouter" }
          it { should have_content('error') }
        end
      end 
    describe "with valid information" do
      before do
        fill_in "Title", with: "test"
        fill_in "Content", with: "Lorem ipsum" 
        fill_in "Periode", with: "12h30" 
      end
      it "should create a scene" do
        expect { click_button "Ajouter" }.to change(Scene, :count).by(1)
      end
    end
  end
  end
  describe "show" do
     let(:scene) { FactoryGirl.create(:scene, chapitre: chapitre) }
     let(:personne) { FactoryGirl.create(:personne) }
	before do
	   scene.save
           personne.save
           visit scene_path(scene)
        end
        describe "personne" do
		before do
			scene.appartient!(personne)
                        visit scene_path(scene)
                end
                it { should have_selector('h3', text: "Personnage (1)") }
                describe "suppression " do
                	before do
				scene.desappartient!(personne) 
				visit scene_path(scene)
                        end
                	it { should have_selector('h3', text: "Personnage (0)") }
		end
        end
	describe "pages" do
          it { should have_selector('h1', text: scene.title) }
          it { should have_selector('title', text: scene.title) }
          it { should have_link('Editer', href: editscene_path(scene)) }
        end
	describe "destroy" do
		it { expect { click_link 'Supprimer Scene' }.to change(Scene, :count).by(-1) }
        end
  end
  describe "edit" do
       let(:scene) { FactoryGirl.create(:scene, chapitre: chapitre) }
	before do
	   scene.save
           visit editscene_path(scene)
        end
       describe "pages" do
          it { should have_selector('h1', text: "Edition Scene") }
          it { should have_selector('title', text: "Edition Scene") }
        end
        
       describe "with invalid information" do

        describe "error messages" do
          before do
             fill_in "Title", with: ""
             click_button "Modifier" 
          end
          it { should have_content('error') }
        end
    end 
    describe "with valid information" do
      let(:new_title) { "nouveau titre" }
      let(:new_content) { "nouveau contenu" }
      let(:new_period) { "00h56" }
      before do
        fill_in "Title", with: new_title
        fill_in "Content", with: new_content
        fill_in "Periode", with: new_period
        click_button "Modifier" 
      end
      it { should have_selector('title', text: full_title(new_title)) }
      it { should have_selector('div.alert.alert-success', text: 'Scene modifie') }
      specify { scene.reload.title.should == new_title }
      specify { scene.reload.content.should == new_content }
      specify { scene.reload.periode.should == new_period }  
    end
  end
end
