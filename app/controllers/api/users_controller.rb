class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      raise ActiveRecord::RecordNotFound, user.errors.full_messages
    end
  end

  def me
    render json: current_user, methods: [:icon_url]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon)
  end
end
