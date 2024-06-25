class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :danger
  skip_before_action :require_login, if: :high_voltage_page?

  private

  def not_authenticated
    redirect_to login_path
  end

  def high_voltage_page?
    controller_path =~ /^high_voltage\/pages/
  end
end
