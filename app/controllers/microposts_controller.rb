class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :fixation, :unfixation]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def latest
    @microposts = Micropost.latest(current_user)
  end

  def fixation
    @micropost = Micropost.find(params[:id])
    if current_user.update(fixed_post: @micropost.id)
      flash[:success] = "Micropost fixed" 
    end
      
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  def unfixation
    if current_user.update(fixed_post: nil)
      flash[:success] = "Micropost unfixed" 
    end
      
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  def search;
    if params[:q].present?
      @users = User.where("name LIKE ?", "%#{params[:q]}%")
      @microposts = Micropost.where("content LIKE ?", "%#{params[:q]}%")
    else
      @users = []
      @microposts = []
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
