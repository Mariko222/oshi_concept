class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]
  skip_before_action :require_login, only: %i[index create]

  def index
    user = User.find_by(uuid: params[:uuid])
    render json: user, methods: [:icon_url]
  end

  def create
    user = User.new(user_params)
    if user.save
      token = user.create_tokens
      render json: { token: token }
    else
      raise ActiveRecord::RecordNotFound, user.errors.full_messages
    end
  end

  def me
    render json: login_user, methods: [:icon_url]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon)
  end
end
