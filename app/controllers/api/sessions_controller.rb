class Api::SessionsController < ApplicationController

  def index
    set_csrf_token
    render json: {}, status: :ok
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = user.create_tokens

      render json: { token: token }
    else
      raise ActiveRecord::RecordNotFound unless user
      head :unauthorized
    end
  end
end
