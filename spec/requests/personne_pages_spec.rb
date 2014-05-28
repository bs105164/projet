require 'spec_helper'

describe "PersonnePages" do
   subject { page }
   let (:personne) { FactoryGirl.create(:personne) }
   
   describe "index" do
     before(:each) do  
         personne.save
         visit personnes_path 
     end
     it { should have_selector('title', text: 'Personnages') }
     it { should have_selector('h1', text: 'Personnages') }
     it { should have_link('Nouveau', href: newpersonne_path) }
     it { should have_link(personne.name, href: personne_path(personne)) }
     it { should have_link('editer', href: editpersonne_path(personne)) }
     it { should have_link('supprimer', href: personne_path(Personne.first)) }
     it "should be able to delete a chapter" do
  	expect do
    		click_link('supprimer')
 	 end.to change(Personne, :count).by(-1)
     end
   end
   describe "personne page" do   
     let(:chapitre) { FactoryGirl.create(:chapitre) }
     let(:scene) { FactoryGirl.create(:scene, chapitre: chapitre) }
     
	before do
	   chapitre.save
	   scene.save
           personne.save
           visit personne_path(personne)
        end
        describe "scene" do
		before do
			scene.appartient!(personne)
                        visit personne_path(personne)
                end
                it { should have_link(scene.title, href: scene_path(scene)) }
                describe "suppression " do
                	before do
				scene.desappartient!(personne) 
				visit personne_path(personne)
                        end
                	it { should_not have_link(scene.title, href: scene_path(scene)) }
		end
        end

     it { should have_selector('h1', text: personne.name) }
     it { should have_selector('title', text: personne.name) } 
     it { should have_link("Editer", href: editpersonne_path(personne)) }
  end
  
  describe "new" do
     before { visit newpersonne_path }
     describe "pages" do  
       it { should have_selector('h1', text: "Creation Personnage") }
       it { should have_selector('title', text: "Creation Personnage") }
    end
  
    describe "form" do
      let(:submit) { "Ajouter Personnage" }
       describe "with invalid information" do
         it { expect { click_button submit }.not_to change(Personne, :count) }
       end

       describe "with valid information" do
         before { fill_in "Name", with: "Sample perso" }
         it { expect { click_button submit }.to change(Personne, :count).by(1) }
       end
    end
  end

    describe "edit" do
     before { visit editpersonne_path(personne) }
     describe "pages" do  
       it { should have_selector('h1', text: "Edition Personnage") }
       it { should have_selector('title', text: "Edition Personnage") }
    end
  
    describe "form" do
      let(:submit) { "Modifier Personnage" }
       describe "with invalid information" do
         before do 
            fill_in "Name", with: " "
            click_button submit 
         end
 
	 it { should have_content('error') }
       end

       describe "with valid information" do
	let(:new_name)  { "New Name" }
        before do  
           fill_in "Name", with: new_name 
           click_button submit
        end

        it { should have_selector('title', text: new_name) }
        it { should have_selector('div.alert.alert-success') }
        specify { expect(personne.reload.name).to  eq new_name }
       end
    end
  end
end
