class TweetsController < ApplicationController
  before_action :move_to_index, except: :index
  def index
    @tweets = Tweet.includes(:user).order("id DESC").page(params[:page]).per(5)
  end

  def new
  end
  def create
    Tweet.create(create_tweet_params)
  end
  def show
    @tweet = Tweet.find(params[:id])
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    tweet = Tweet.find(params[:id])
    tweet.update(edit_tweet_params) if tweet.user_id == current_user.id
  end
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
  def create_tweet_params
    params.permit(:text).merge(user_id: current_user.id)
  end
  def edit_tweet_params
    params.require(:tweet).permit(:text)
  end
end
