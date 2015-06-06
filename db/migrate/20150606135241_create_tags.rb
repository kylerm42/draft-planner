class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.boolean     :sleeper,  default: false
      t.boolean     :bust,     default: false
      t.boolean     :injury,   default: false
      t.boolean     :removed,  default: false
      t.text        :notes
      t.references  :sheet,   index: true, foreign_key: true
      t.references  :player,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
