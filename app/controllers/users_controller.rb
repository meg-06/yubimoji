class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create my_account]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to mypage_path, notice: 'ユーザー登録が完了しました'
    else
      render :new
    end
  end

  def destroy
    current_user.destroy
    logout
    redirect_to root_path, notice: '退会しました'
  end

  def my_account
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
