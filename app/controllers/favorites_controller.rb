class FavoritesController < ApplicationController
  before_action :set_hiragana, only: [:create, :destroy]
  before_action :require_login


  def index
    @favorites = current_user.favorites.page(params[:page])
  end

  def create
    @favorite = current_user.favorites.create(hiragana: @hiragana)
    redirect_to hiraganas_path, success: 'お気に入りに追加しました。'
  end

  def destroy
    @favorite = current_user.favorites.find(params[:hiragana_favorite_id])
    @favorite.destroy
    redirect_to favorites_path, danger: 'お気に入りを解除しました。'
  end

  private

  def set_hiragana
    @hiragana = Hiragana.find(params[:hiragana_id])
  end
end