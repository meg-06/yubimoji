class Hiragana < ApplicationRecord
  validates :character, presence: true, uniqueness: true, length: { maximum: 20 }, format: { with: /\A[ぁ-んー－]+\z/ }

  belongs_to :user
end
