class Hiragana < ApplicationRecord
  validates :character, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 20 }, format: { with: /\A[ぁ-んー－]+\z/ }

  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sign_language

  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user
end