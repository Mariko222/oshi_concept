class Api::MygenresController < ApplicationController
  before_action :authenticate!, only: %i[me]
  skip_before_action :verify_authenticity_token

  def create
    @mygenre = current_user.mygenres.build(genre_id: params[:id], params[:mygenre_favorite_characters_attributes] [:character_id])
    if @mygenre.save
      render json: @mygenre
    else
      render json: @mygenre.errors, status: :bad_request
    end
  end
end
