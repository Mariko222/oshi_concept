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

    raise ActiveRecord::RecordNotFound if params[:character_ids].count > 4

    mygenre_favorite_characters = []
    params[:character_ids].each do |character_id|
      mygenre_favorite_character = MygenreFavoriteCharacter.new(mygenre_id: mygenre.id, character_id: character_id)
      if mygenre_favorite_characters.count < 4
        mygenre_favorite_character.save
        mygenre_favorite_characters.push(mygenre_favorite_character)
      end
    end

    render json: mygenre_favorite_characters
  end

  def destroy
    @mygenre_favorite_character.destroy!
    render json: @mygenre_favorite_character
  end

  private

  def set_character
    binding.pry
    @mygenre_favorite_character = MygenreFavoriteCharacter.find(params[:id])
  end
end
