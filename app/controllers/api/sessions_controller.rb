class Api::SessionsController < ApplicationController
  skip_before_action :require_login

  def index
    @user = User.find(login_user.id)
    render json: @user
  end

  def create
    if params[:email]
      user = User.authenticate(params[:email], params[:password])
    else
      user = User.find(params[:id])
      auto_login(user)
    end
    raise ActiveRecord::RecordNotFound unless user

    if user.uuid == nil
      user.update(uuid: SecureRandom.uuid)
    end

    token = user.create_tokens
    render json: { token: token }
  end
end
