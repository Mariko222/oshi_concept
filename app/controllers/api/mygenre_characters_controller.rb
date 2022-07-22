class Api::MygenreCharactersController < ApplicationController
  before_action :authenticate!

  def index
    @genres = current_user.mygenre_lists
    render json: @genres
  end
end
