class Api::MygenreCharactersController < ApplicationController
  def index
    @user = User.find_by(uuid: params[:uuid])
    @genres = @user.mygenre_lists
    render json: @genres
  end
end
