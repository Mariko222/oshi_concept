require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:mygenre) { create(:mygenre) }
  let(:new_post) { create(:post) }

  context "GET /api/posts" do
    example "ログインしているユーザーの投稿一覧を取得できる" do
      token = login(new_post.user)
      get api_posts_path(new_post.user.uuid), headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end

  context "POST /api/posts" do
    example "投稿を追加できる" do
      token = login(new_post.user)
      post api_posts_path, params: { category: "fashion", type: "twitter", url: "https://twitter.com/oshi_concept/status/1568209227705122821?s=20&t=vfLsJB1iDahS8QQ50QB3YQ", mygenre_id: mygenre.id, post: { category: "fashion", type: "twitter", url: "https://twitter.com/oshi_concept/status/1568209227705122821?s=20&t=vfLsJB1iDahS8QQ50QB3YQ", mygenre_id: mygenre.id } }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Post.count).to eq(2)
    end

    example "パラメーターが不正で投稿を追加できない" do
      token = login(new_post.user)
      post api_posts_path, params: { category: "fashion", type: "twitter", url: "", mygenre_id: mygenre.id, post: { category: "fashion", type: "twitter", url: "", mygenre_id: mygenre.id } }, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(404)
      expect(Post.count).to eq(1)
    end
  end

  context "DELETE /api/posts/:id" do
    example "投稿を削除できる" do
      token = login(new_post.user)
      delete api_post_path(new_post.id), headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Post.count).to eq(0)
    end
  end
end
