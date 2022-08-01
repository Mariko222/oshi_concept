class ApplicationController < ActionController::Base
  include Api::ExceptionHandler
  include Api::UserAuthenticator
  # protect_from_forgeryを有効化
  include ActionController::RequestForgeryProtection
  # APiモードでのCookieを使用するために読み込む
  include ActionController::Cookies

  protect_from_forgery with: :null_session

  private

  def set_csrf_token
    cookies['CSRF-TOKEN'] = {
      domain: Settings.default_url_options.cookie_host,
      value: form_authenticity_token
    }
  end
end
