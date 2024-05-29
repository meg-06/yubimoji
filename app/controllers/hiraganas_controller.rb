class HiraganasController < ApplicationController
  def index
    @hiraganas = current_user.hiraganas.page(params[:page])
  end

  def new
    @hiragana = Hiragana.new
  end

  def create
    @hiragana = current_user.hiraganas.build(hiragana_params)
    if @hiragana.save
      redirect_to new_hiragana_path, success: 'ひらがなを登録しました'
    else
      flash.now[:danger] = '既に登録されているひらがなです'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @hiragana = Hiragana.find(params[:id])
    characters = @hiragana.character.chars
    @sign_languages = characters.map { |char| SignLanguage.find_by(character: char) }
  end

  def destroy
    @hiragana = current_user.hiraganas.find(params[:id])
    @hiragana.destroy!
    redirect_to hiraganas_path, notice: 'ひらがなを削除しました'
  end

  private

  def hiragana_params
    params.require(:hiragana).permit(:character, :sign_language_id)
  end
end
