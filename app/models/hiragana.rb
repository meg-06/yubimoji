class Hiragana < ApplicationRecord
  validates :character, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 20 }, format: { with: /\A[ぁ-んー－]+\z/ }

  belongs_to :user
end
