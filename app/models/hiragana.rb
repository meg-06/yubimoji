class Hiragana < ApplicationRecord
  belongs_to :user, optional: true

  validate :character_presence
  validate :character_uniqueness, if: -> { character.present? && user_id.present? }
  validate :character_format, if: -> { character.present? }

  private

  def character_presence
    errors.add(:base, '入力してください') if character.blank?
  end

  def character_uniqueness
    if Hiragana.exists?(character: character, user_id: user_id)
      errors.add(:base, 'この単語は既に登録されています')
    end
  end

  def character_format
    unless character =~ /\A[\p{hiragana}ー－]+\z/
      errors.add(:base, 'ひらがなで入力してください')
    end
  end
end
