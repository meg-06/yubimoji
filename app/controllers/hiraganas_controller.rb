class HiraganasController < ApplicationController
  def index
    @hiraganas = current_user.hiraganas
  end

  def new
    @hiragana = Hiragana.new
  end

  def create
    @hiragana = current_user.hiraganas.build(hiragana_params)
    if @hiragana.save
      redirect_to hiraganas_path, notice: 'ひらがなを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @hiragana = current_user.hiraganas.find(params[:id])
  end

  def destroy
    @hiragana = current_user.hiraganas.find(params[:id])
    @hiragana.destroy!
    redirect_to hiraganas_path, notice: 'ひらがなを削除しました'
  end

  private

  def hiragana_params
    params.require(:hiragana).permit(:character)
  end
end
