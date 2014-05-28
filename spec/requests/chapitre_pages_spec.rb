require 'spec_helper'

describe "ChapitrePages" do
   subject { page }
   let (:chapitre) { FactoryGirl.create(:chapitre) }
   
   describe "index" do
     before(:each) do  
         chapitre.save
         visit chapitres_path 
     end
     it { should have_selector('title', text: 'Chapitres') }
     it { should have_selector('h1', text: 'Chapitres') }
     it { should have_link('Chapitres', href: chapters_path) }
     it { should have_link('Personnages', href: personnes_path) }
     it { should have_link('Nouveau', href: newchapter_path) }
     it { should have_link(chapitre.name, href: chapitre_path(chapitre)) }
     it { should have_link('editer', href: editchapter_path(chapitre)) }
     it { should have_link('supprimer', href: chapitre_path(Chapitre.first)) }
     it "should be able to delete a chapter" do
  	expect do
    		click_link('supprimer')
 	 end.to change(Chapitre, :count).by(-1)
     end

     describe "pagination" do
       before(:all) { 30.times { FactoryGirl.create(:chapitre) } }
       after(:all) { Chapitre.delete_all }

       it { should have_selector ('div.pagination') }
       it "shoud list each user" do
	  Chapitre.paginate(page: 1).each do |chapitre|
            expect(page).to have_selector('li', text: chapitre.name)
          end
       end
     end 
   end
   describe "chapitre page" do   
     let!(:s1) { FactoryGirl.create(:scene, chapitre: chapitre) }
     let!(:s2) { FactoryGirl.create(:scene, chapitre: chapitre) }
     let!(:a1) { FactoryGirl.create(:anecdote, chapitre: chapitre) }
     let!(:a2) { FactoryGirl.create(:anecdote, chapitre: chapitre) }  
     before do 
        chapitre.save
        s1.save
        s2.save
        a1.save
        a2.save
        visit chapitre_path(chapitre)
     end

     it { should have_selector('h1', text: chapitre.name) }
     it { should have_selector('title', text: chapitre.name) }
     it { should have_link("Nouvelle Scene", href: newscene_path(chapitre)) }
     it { should have_link(s1.title, href: scene_path(s1)) } 
     it { should have_link(s2.title, href: scene_path(s2)) }    
     it { should have_content(chapitre.scenes.count) }
     it { should have_link("Nouvelle Anecdote", href: newanecdote_path(chapitre)) }
     it { should have_link(a1.sujet, href: anecdote_path(a1)) } 
     it { should have_link(a2.sujet, href: anecdote_path(a2)) }    
     it { should have_content(chapitre.scenes.count) }
  end
  
  describe "new" do
     before { visit newchapter_path }
     describe "pages" do  
       it { should have_selector('h1', text: "Nouveau Chapitre") }
       it { should have_selector('title', text: "Nouveau Chapitre") }
    end
  
    describe "form" do
      let(:submit) { "Ajouter Chapitre" }
       describe "with invalid information" do
         it { expect { click_button submit }.not_to change(Chapitre, :count) }
       end

       describe "with valid information" do
         before { fill_in "Name", with: "Sample chapter" }
         it { expect { click_button submit }.to change(Chapitre, :count).by(1) }
       end
    end
  end

    describe "edit" do
     let (:chapitre) { FactoryGirl.create(:chapitre) }
     before { visit editchapter_path(chapitre) }
     describe "pages" do  
       it { should have_selector('h1', text: "Edition Chapitre") }
       it { should have_selector('title', text: "Edition Chapitre") }
    end
  
    describe "form" do
      let(:submit) { "Modifier Chapitre" }
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
        specify { expect(chapitre.reload.name).to  eq new_name }
       end
    end
  end
end
