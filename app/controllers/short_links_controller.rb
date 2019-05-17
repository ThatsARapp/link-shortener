class ShortLinksController < ApplicationController
  before_action :fetch_short_link, only: [ :show, :edit, :update]

  def index
    @short_link = ShortLink.find(ShortLink.decode_url(params[:short_url]))
    @short_link.increment_view_count unless @short_link.original_url == '/404.html'
    redirect_to @short_link.original_url
  end

  def new
    @short_link = ShortLink.new
  end

  def create
    @short_link = ShortLink.new(short_link_params)
    if @short_link.save
      redirect_to @short_link
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @short_link.expire_url
    redirect_to action: 'new'
  end

  private

  def fetch_short_link
    @short_link = ShortLink.find(params[:id])
  end

  def short_link_params
    params.require(:short_link).permit(:original_url)
  end
end
