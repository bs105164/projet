class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.string :title
      t.integer :chapitre_id
      t.text :content
      t.string :periode

      t.timestamps
    end
    add_index :scenes, [:chapitre_id, :created_at]
  end
end
