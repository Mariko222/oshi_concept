class Api::MygenresController < ApplicationController
  before_action :set_character, only: %i[destroy]
  before_action :authenticate!, only: %i[me]
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login

  def index
    @user = User.find_by(uuid: params[:uuid])
    @mygenres = Mygenre.where(user_id: @user.id)
    respond_to do |f|
      f.json { render json: @mygenres.to_json(include: [:genre]) }
    end
  end

  def create
    mygenre = Mygenre.find_by(user_id: login_user.id, genre_id: params[:genre_id])
    mygenre_favorite_characters = []
    params[:character_ids].each do |character_id|
      mygenre_favorite_character = MygenreFavoriteCharacter.new(mygenre_id: mygenre.id, character_id: character_id)
      if mygenre_favorite_character.save
        mygenre_favorite_characters.push(mygenre_favorite_character)
      end
    end

    if mygenre_favorite_characters.all?
      render json: mygenre_favorite_characters
    else
      render json: mygenre_favorite_characters.errors, status: :bad_request
    end
  end

  def destroy
    @mygenre_favorite_character.destroy!
    render json: @mygenre_favorite_character
  end

  private

  def set_character
    @mygenre_favorite_character = MygenreFavoriteCharacter.find(params[:id])
  end
end
