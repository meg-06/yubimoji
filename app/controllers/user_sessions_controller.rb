class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to mypage_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def mypage
    @user = current_user
    @hiragana = @user.hiraganas.last
    if @hiragana
      characters = @hiragana.character.chars
      @sign_languages = characters.map { |char| SignLanguage.find_by(character: char) }
    else
      @sign_languages = []
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end

