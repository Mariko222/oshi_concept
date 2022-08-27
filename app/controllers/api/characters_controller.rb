class Api::CharactersController < ApplicationController
  before_action :authenticate!
  skip_before_action :require_login

  def index
    @characters = Character.where(genre_id: params[:id])
    render json: @characters
  end
end
