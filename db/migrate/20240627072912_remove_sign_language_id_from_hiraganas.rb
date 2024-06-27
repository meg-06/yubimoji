class RemoveSignLanguageIdFromHiraganas < ActiveRecord::Migration[7.1]
  def change
    remove_column :hiraganas, :sign_language_id, :integer
  end
end
