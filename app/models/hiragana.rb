class Hiragana < ApplicationRecord
  validates :character, presence: { message: '入力してください' }
  validates :character, uniqueness: { scope: :user_id, message: 'この単語は既に登録されています' }, if: -> { character.present? }
  validates :character, format: { with: /\A[\p{hiragana}ー－]+\z/, message: 'ひらがなで入力してください' }, if: -> { character.present? }

  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sign_language

  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user
end