RailsAdmin.config do |config|
  config.parent_controller = 'ApplicationController'
  config.current_user_method(&:current_user)

  config.authenticate_with do
    require_login
    redirect_to main_app.admin_login_path, notice: "権限がありません"  unless current_user.admin?
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end

  ## == CancanCan ==
  config.authorize_with :cancancan
  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.main_app_name = %w(推し概念集めてみた 管理画面)
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
