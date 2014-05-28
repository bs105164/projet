class CreateAnecdotes < ActiveRecord::Migration
  def change
    create_table :anecdotes do |t|
      t.text :content
      t.string :sujet
      t.text :themes
      t.integer :chapitre_id

      t.timestamps
    end
  end
end
