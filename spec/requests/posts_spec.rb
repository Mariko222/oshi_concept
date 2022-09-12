require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:new_post) { create(:post) }

  context "GET /api/posts" do
    example "ログインしているユーザーの投稿一覧を取得できる" do
      token = login(new_post.user)
      get api_posts_path(new_post.user.uuid), headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end
  end
end
