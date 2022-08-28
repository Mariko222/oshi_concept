class Api::PostsController < ApplicationController
  before_action :authenticate!, only: %i[create destroy]
  before_action :set_post, only: %i[destroy]
  skip_before_action :require_login

  def index
    @user = User.find_by(uuid: params[:uuid])
    posts = @user.posts.all
    render json: posts, each_serializer: PostSerializer
  end

  def create
    mygenre = Mygenre.find(params[:mygenre_id])
    post = mygenre.posts.build(amazon_page_params) if params[:url].include?("amazon")
    post = mygenre.posts.build(webpage_params) if params[:type] == 'webpage' && params[:url].exclude?("amazon")
    post = mygenre.posts.build(post_params) if params[:type] == 'twitter'

    if post.save
      render json: post
    else
      raise ActiveRecord::RecordNotFound, post.errors.full_messages
    end
  end

  def destroy
    @post.destroy!
    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:category, :type, :url, :mygenre_id)
  end

  def webpage_params
    agent = Mechanize.new
    agent.user_agent_alias = "Windows Mozilla"
    page = agent.get(params[:post][:url])
    ogp = page.at("meta[property='og:image']").try(:[], :content)
    params.require(:post).permit(:category, :type, :url, :mygenre_id).merge(title: page.title, image: ogp)
  end

  def amazon_page_params
    agent = Mechanize.new
    agent.user_agent_alias = "Windows Mozilla"
    page = agent.get(params[:post][:url])
    amazon_title = params[:url].split('/')[3]
    agent.page.encoding = 'Shift_JIS'
    params.require(:post).permit(:category, :type, :mygenre_id).merge(title: amazon_title, url:agent.page.uri.to_s)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
