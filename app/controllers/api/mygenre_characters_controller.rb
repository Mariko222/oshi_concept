class Api::MygenreCharactersController < ApplicationController
  before_action :authenticate!
  skip_before_action :require_login
  def index
    @user = User.find_by(uuid: params[:uuid])
    @genres = @user.mygenre_lists
    render json: @genres
  end
end
