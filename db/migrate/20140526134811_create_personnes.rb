class CreatePersonnes < ActiveRecord::Migration
  def change
    create_table :personnes do |t|
      t.string :name

      t.timestamps
    end
  end
end
