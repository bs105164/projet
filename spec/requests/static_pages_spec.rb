require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'assistant d\'ecriture') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Home') }
    it { should have_link('Chapitres', href: chapters_path) }
    it { should have_link('Personnages', href: personnes_path) }
  end
  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
    it { should have_link('Chapitres', href: chapters_path) }
    it { should have_link('Personnages', href: personnes_path) }
  end
end
