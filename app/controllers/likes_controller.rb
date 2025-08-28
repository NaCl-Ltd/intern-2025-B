class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.likes.create(micropost_id: @micropost.id)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    like = current_user.likes.find_by(micropost_id: @micropost.id)
    like.destroy
    redirect_back(fallback_location: root_url)
  end
end