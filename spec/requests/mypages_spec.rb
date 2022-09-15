require 'rails_helper'

RSpec.describe "Mypages", type: :request do
  let(:mygenre) { create(:mygenre) }

  context "POST /api/mypage" do
    example "ジャンルと推しを追加できる" do
      token = login(mygenre.user)
      post api_mypage_index_path, params: { genre_id: 2, character_ids: [54] }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(MygenreFavoriteCharacter.count).to eq(1)
    end
    example "既に登録済みのジャンルと推しを追加できない" do
      token = login(mygenre.user)
      post api_mypage_index_path, params: { genre_id: 1, character_ids: [1] }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(500)
      expect(MygenreFavoriteCharacter.count).to eq(0)
    end
  end

  context "PATCH /api/mypage/:id" do
    example "ログインしているユーザーのマイページを編集できる" do
      token = login(mygenre.user)
      patch api_mypage_path(mygenre.user.id), params: { user: { name: "test2", mypage_name: "mypage2" } }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end
end
