class CreateChapitres < ActiveRecord::Migration
  def change
    create_table :chapitres do |t|
      t.string :name

      t.timestamps
    end
  end
end
