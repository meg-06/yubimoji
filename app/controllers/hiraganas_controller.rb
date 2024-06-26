class HiraganasController < ApplicationController
  skip_before_action :require_login, only: %i[trial]
  layout 'alternative', only: [:index]

  def index
    @hiraganas = current_user.hiraganas.page(params[:page]).order(created_at: :desc)
  end

  def new
    @hiragana = Hiragana.new
  end

  def create
    @hiragana = current_user.hiraganas.build(hiragana_params)
    if @hiragana.save
      redirect_to new_hiragana_path, success: 'ひらがなを登録しました'
    else
      flash.now[:danger] = @hiragana.errors.messages.values.flatten.join(', ')
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

  def study
    @hiragana = Hiragana.find(params[:id])
    characters = @hiragana.character.chars
    @sign_languages = characters.map { |char| SignLanguage.find_by(character: char) }
  end


  def trial
    characters = params[:character]&.chars || []
    @sign_languages = characters.map { |char| SignLanguage.find_by(character: char) }
  end

  def next
    @hiragana = current_user.hiraganas.where.not(id: session[:last_hiragana_id]).order("RANDOM()").first
    if @hiragana.nil?
      session[:last_hiragana_id] = nil
      @hiragana = current_user.hiraganas.order("RANDOM()").first
    end
    if @hiragana.nil?
      redirect_to mypage_path, notice: "これ以上問題がありません"
    else
      session[:last_hiragana_id] = @hiragana.id
      redirect_to study_hiragana_path(@hiragana.id)
    end
  end

  def next_word
    @current_hiragana = Hiragana.find(params[:id])
    @next_hiragana = current_user.hiraganas.where('id < ?', @current_hiragana.id).order(id: :desc).first

    if @next_hiragana
      redirect_to hiragana_path(@next_hiragana.id)
    else
      redirect_to hiragana_path(current_user.hiraganas.order(id: :desc).first.id), notice: '最初の単語に戻ります'
    end
  end

  private

  def hiragana_params
    params.require(:hiragana).permit(:character)
  end
end
