class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  layout 'alternative', only: [:mypage]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to mypage_path
    else
      render :new
    end
  end

  def mypage
    @user = current_user
    @hiragana = Hiragana.last
    characters = @hiragana.character.chars
    @sign_languages = characters.map { |char| SignLanguage.find_by(character: char) }
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
