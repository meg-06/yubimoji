class CreateHiraganas < ActiveRecord::Migration[7.1]
  def change
    create_table :hiraganas do |t|
      t.string :character, limit: 20, null: false

      t.timestamps
    end
  end
end
