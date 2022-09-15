require 'rails_helper'

RSpec.describe "Mygenres", type: :request do
  let(:mygenre) { create(:mygenre) }
  let(:mygenre_favorite_character) { create(:mygenre_favorite_character) }

  context "GET /api/mypage" do
    example "ログインしているユーザーのジャンルと推しを取得できる" do
      token = login(mygenre.user)
      get api_mypage_index_path(mygenre.user.uuid), headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end

  context "POST /api/mygenres" do
    example "推しを追加できる" do
      token = login(mygenre.user)
      post api_mygenres_path, params: { genre_id: 1, character_ids: [1, 2] }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(MygenreFavoriteCharacter.count).to eq(2)
    end
    example "推しを4人以上追加できない" do
      token = login(mygenre.user)
      post api_mygenres_path, params: { genre_id: 1, character_ids: [1, 2, 3, 4, 5] }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(404)
      expect(MygenreFavoriteCharacter.count).to eq(0)
    end
  end

  context "DELETE /api/mygenres/:id" do
    example "推しを削除できる" do
      mygenre
      mygenre_favorite_character
      token = login(mygenre.user)
      delete api_mygenre_path(1), headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(MygenreFavoriteCharacter.count).to eq(0)
    end
  end
end
