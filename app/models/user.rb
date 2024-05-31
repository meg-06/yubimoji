class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  has_many :hiraganas, dependent: :destroy
  has_many :favorites
  has_many :favorite_hiraganas, through: :favorites, source: :hiragana

  def favorite(hiragana)
    favorite_hiraganas << hiragana
  end

  def unfavorite(hiragana)
    favorites.find_by(hiragana_id: hiragana.id).destroy
  end

  def favorited?(hiragana)
    favorite_hiraganas.include?(hiragana)
  end
end
