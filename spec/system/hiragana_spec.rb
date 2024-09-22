require 'rails_helper'

RSpec.describe '日本語登録機能', type: :system do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password') }
  let!(:hiragana) { Hiragana.create!(character: 'こんにちは', user: user) }
  before do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
    visit hiraganas_path
    fill_in 'hiragana_character', with: 'こんにちは'
    click_button '登録'
  end
  it 'ユーザーが日本語を正しく登録できる' do
    expect(page).to have_content 'こんにちは'
  end

  it 'ユーザーが日本語をお気に入り登録できる' do
    click_button 'お気に入り登録'
    expect(page).to have_content 'こんにちは'
  end

  it 'ユーザーが日本語をお気に入り解除できる' do
    click_button 'お気に入り登録'
    expect(page).to have_content 'こんにちは'
  end

  it 'ユーザーが日本語を正しく削除できる' do
    click_button '削除'
    expect(page).not_to have_content 'こんにちは'
  end

  it 'ユーザーが登録した日本語が指文字に変換されるか' do
    click_link 'こんにちは'
    expect(page).to have_current_path(hiragana_path(hiragana))
    expect(page).to have_css("img[src*='こ']")
    expect(page).to have_css("video > source[src*='ん']")
    expect(page).to have_css("img[src*='に']")
    expect(page).to have_css("img[src*='ち']")
    expect(page).to have_css("img[src*='は']")
  end
end
