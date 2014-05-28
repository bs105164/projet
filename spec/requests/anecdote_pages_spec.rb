describe "AnecdotesPages" do
  subject { page }
  let(:chapitre) { FactoryGirl.create(:chapitre) }
  before { chapitre.save }
  describe "new" do
     before do
           visit newanecdote_path(chapitre)
        end
     describe "pages" do
       it { should have_selector('h1', text: "Creation Anecdote") }
       it { should have_selector('title', text: "Creation Anecdote") }
     end
     describe "form" do
	
            describe "with invalid information" do

        it "should not create a anecdote" do
          expect { click_button "Ajouter" }.not_to change(Anecdote, :count)
        end

        describe "error messages" do
          before { click_button "Ajouter" }
          it { should have_content('error') }
        end
      end 
    describe "with valid information" do
      before do
        fill_in "Sujet", with: "test"
        fill_in "Content", with: "Lorem ipsum" 
        fill_in "Themes", with: "Reproduction des crevettes" 
      end
      it "should create a anecdote" do
        expect { click_button "Ajouter" }.to change(Anecdote, :count).by(1)
      end
    end
  end
  describe "show" do
     let(:anecdote) { FactoryGirl.create(:anecdote, chapitre: chapitre) }
	before do
	   anecdote.save
           visit anecdote_path(anecdote)
        end
	describe "pages" do
          it { should have_selector('h1', text: anecdote.sujet) }
          it { should have_selector('title', text: anecdote.sujet) }
          it { should have_link('Editer', href: editanecdote_path(anecdote)) }
        end
	describe "destroy" do
		it { expect { click_link 'Supprimer' }.to change(Anecdote, :count).by(-1) }
        end
  end

  describe "edit" do
       let(:anecdote) { FactoryGirl.create(:anecdote, chapitre: chapitre) }
	before do
	   anecdote.save
           visit editanecdote_path(anecdote)
        end
       describe "pages" do
          it { should have_selector('h1', text: "Edition Anecdote") }
          it { should have_selector('title', text: "Edition Anecdote") }
        end
        
       describe "with invalid information" do

        describe "error messages" do
          before do
             fill_in "Sujet", with: ""
             click_button "Modifier" 
          end
          it { should have_content('error') }
        end
    end 
    describe "with valid information" do
      let(:new_title) { "nouveau titre" }
      let(:new_content) { "nouveau contenu" }
      let(:new_themes) { "nouveau theme" }
      before do
        fill_in "Sujet", with: new_title
        fill_in "Content", with: new_content
        fill_in "Themes", with: new_themes
        click_button "Modifier" 
      end
      it { should have_selector('title', text: full_title(new_title)) }
      it { should have_selector('div.alert.alert-success', text: 'Anecdote modifie') }
      specify { anecdote.reload.sujet.should == new_title }
      specify { anecdote.reload.content.should == new_content }
      specify { anecdote.reload.themes.should == new_themes }  
    end
  end
 end
end
