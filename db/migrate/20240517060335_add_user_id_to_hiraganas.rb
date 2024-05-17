class AddUserIdToHiraganas < ActiveRecord::Migration[7.1]
  def change
    add_reference :hiraganas, :user, foreign_key: true
  end
end
