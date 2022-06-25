class Api::MygenresController < ApplicationController
  before_action :authenticate!, only: %i[me]
  skip_before_action :verify_authenticity_token

  def create
    @myfavorite_character = MyfavoriteCharacter.new(set_params)
    if @myfavorite_character.save
      render json: @myfavorite_character.attributes
    else
      render json: @myfavorite_character.errors, status: :bad_request
    end
  end

  private

  def set_params
    params.permit(:current_user, :genre_id, character_ids:[]).merge(user_id: User.find(current_user.id).id)
  end
end
