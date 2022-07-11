class Api::PostsController < ApplicationController
  before_action :authenticate!

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    mygenre = Mygenre.find(params[:mygenre_id])
    @post = mygenre.posts.build(webpage_params) if params[:type] == 'webpage'

    @post = mygenre.posts.build(post_params) if params[:type] == 'twitter'

    if @post.save
      render json: @post
    else
      render json: @post.errors, status: :bad_request
    end
  end

  private

  def post_params
    params.require(:post).permit(:category, :type, :url, :mygenre_id)
  end

  def webpage_params
    agent = Mechanize.new
    page = agent.get(params[:post][:url])
    content = page.at('meta[property="og:description"]')[:content]
    ogp = page.at("meta[property='og:image']")[:content]
    params.require(:post).permit(:category, :type, :url, :mygenre_id).merge(title: page.title,text: content, image: ogp)
  end
end
