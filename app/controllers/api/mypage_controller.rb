class Api::MypageController < ApplicationController
  before_action :authenticate!, only: %i[create update]
  skip_before_action :require_login

  def index
    @user = User.find_by(uuid: params[:uuid])
    @mygenres = Mygenre.where(user_id: @user.id)
    @genres = @user.mygenre_lists
    @mygenre_favorite_characters = MygenreFavoriteCharacter.where(mygenre_id: @mygenres.ids)
    respond_to do |f|
      f.json { render json: @mygenre_favorite_characters.to_json(include: [:character, { mygenre: {include: :genre}}]) }
    end
  end

  def create
    myfavorite_character = MyfavoriteCharacter.new(set_params)
    if myfavorite_character.save
      render json: myfavorite_character.attributes
    else
      raise ActiveRecord::RecordNotFound, myfavorite_character.errors.full_messages
    end
  end

  def update
    user = User.find(login_user.id)
    if user.update(user_params)
      render json: user, methods: [:icon_url]
    else
      raise ActiveRecord::RecordNotFound user.errors.full_messages
      render json: user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mypage_name, :icon)
  end

  def set_params
    params.permit(:login_user, :genre_id, character_ids:[]).merge(user_id: User.find(login_user.id).id)
  end
end
