class TweetsController < ApplicationController
  #ログインしていなかったら、このコントローラーの全ての機能を使えない
  before_action :authenticate_user!

  #全ての投稿を表示する画面
  def index
    @tweets = Tweet.all.order("id DESC")
  end

  #新しいTweetを投稿するときに使う
  def new
    @tweet = Tweet.new
  end

  #新しいTweetの保存
  def create
    @tweet = Tweet.new(tweet_params)
    #現在のUserのidをTweetのuser_idという部分にセット
    @tweet.user_id = current_user.id
    #新しいTweetの保存に成功した場合
    if @tweet.save
      #index.html.erbにページが移る
      redirect_to action: "index"
    #新しいTweetの保存に失敗した場合
    else
      #もう一回投稿画面へ
      redirect_to action: "new"
    end
  end

  #mypageの表示
  def mypage
    #アソシエーションを利用して、現在のユーザーが持っている全てのTweetを取得
    @tweets = current_user.tweets.order("id DESC")
  end

  private
  #セキュリティのため、許可した:bodyというデータだけ取ってくるようにする
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
