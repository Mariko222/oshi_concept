class Api::SessionsController < ApplicationController

  def index
    @user = User.find(current_user.id)
    render json: @user
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = user.create_tokens

      render json: { token: token }
    else
      head :unauthorized
    end
  end
end
