class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.string      :position,    null: false
      t.references  :collection,  index: true, foreign_key: true
      t.integer     :ranks,       null: false, array: true

      t.timestamps null: false
    end

    add_index :sheets, [:position, :collection_id], unique: true
  end
end
