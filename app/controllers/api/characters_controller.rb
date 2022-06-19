class Api::CharactersController < ApplicationController
  before_action :authenticate!

  def index
    @characters = Character.where(genre_id: params[:id])
    render json: @characters
  end
end
