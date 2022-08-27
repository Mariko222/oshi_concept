class Api::GenresController < ApplicationController
  before_action :authenticate!
  skip_before_action :require_login

  def index
    @genres = Genre.all
    render json: @genres
  end
end
