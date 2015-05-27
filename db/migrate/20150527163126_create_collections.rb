class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string      :name,        null: false
      t.references  :user,        index: true, foreign_key: true
      t.boolean     :default,     default: false

      t.timestamps                null: false
    end

    add_index :collections, :default
  end
end
