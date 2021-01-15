class TweetsController < ApplicationController
  def create

    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      @user = session.user
      @tweet = @user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create' # can be omitted
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id])
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session and @tweet and @tweet.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def index
    @tweets = Tweet.all
    render 'tweets/index' # can be omitted
  end

  def index_by_user
    @user = User.find_by(username: params[:username])
    if @user
      @tweets = @user.tweets
      render 'tweets/index' # can be omitted
    else
      render json: { tweets: [] }
    end
  end

  private
    def tweet_params
      params.require(:tweet).permit(:message, :user_id)
    end
end
