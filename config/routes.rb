Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  root to: "hello#index"

  #Tweetの投稿に関するページ
  #投稿ページ表示
  get "/tweets/new" => "tweets#new"
  #投稿し、ホームに戻る
  post "/tweets/new" => "tweets#create"
  #投稿一覧
  get "/tweets/index" => "tweets#index"
  #マイページの表示
  get "/tweets/mypage" => "tweets#mypage"
end
