class ApplicationController < ActionController::Base
  include Api::ExceptionHandler
  include Api::UserAuthenticator

  protect_from_forgery with: :null_session

  def not_authenticated
    
    # Make sure that we reference the route from the main app.
    redirect_to main_app.admin_login_path, notice: "ログインしてください"
  end
end
