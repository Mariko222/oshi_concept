class Api::MypageController < ApplicationController
  before_action :authenticate!

  def index
    @mygenres = Mygenre.where(user_id: current_user.id)
    @genres = current_user.mygenre_lists
    @mygenre_favorite_characters = MygenreFavoriteCharacter.where(mygenre_id: @mygenres.ids)
    respond_to do |f|
      f.json { render json: @mygenre_favorite_characters.to_json(include: [:character, { mygenre: {include: :genre}}]) }
    end
  end

  def create
    @myfavorite_character = MyfavoriteCharacter.new(set_params)
    if @myfavorite_character.save
      render json: @myfavorite_character.attributes
    else
      render json: @myfavorite_character.errors, status: :bad_request
    end
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user, methods: [:icon_url]
    else
      render json: user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mypage_name, :icon)
  end

  def set_params
    params.permit(:current_user, :genre_id, character_ids:[]).merge(user_id: User.find(current_user.id).id)
  end
end
