class AddSignLanguageIdToHiraganas < ActiveRecord::Migration[7.1]
  def change
    add_column :hiraganas, :sign_language_id, :integer
  end
end
