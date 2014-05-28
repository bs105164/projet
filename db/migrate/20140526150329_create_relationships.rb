class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :personne_id
      t.integer :scene_id

      t.timestamps
    end
    add_index :relationships, :personne_id
    add_index :relationships, :scene_id
    add_index :relationships, [:personne_id, :scene_id], unique: true
  end
end
