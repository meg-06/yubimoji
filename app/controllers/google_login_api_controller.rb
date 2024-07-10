class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token
  skip_before_action :require_login, only: [:callback]

  def callback
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV['GOOGLE_CLIENT_ID'])
    user = User.find_or_create_by(email: payload['email']) do |user|
      user.name = payload['name'] if user.name.blank?
      user.password = SecureRandom.hex(15) if user.crypted_password.blank?  # ダミーのパスワードを設定
    end

    # ユーザーをデータベースに保存
    user.save(validate: false)

    # Sorceryのauto_loginメソッドを使用してログイン
    auto_login(user)
    logger.debug "User logged in: #{current_user.inspect}"
    redirect_to mypage_path, notice: 'ログインしました'
  end

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      redirect_to root_path, notice: '不正なアクセスです'
    end
  end
end
