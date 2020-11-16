Rails.application.routes.draw do
  #管理者アカウント
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  resources :admins, only: [:show]

  #ワーカーアカウント
  devise_for :workers, controllers: {
    registrations: 'workers/registrations',
    sessions: 'workers/sessions',
    confirmations: 'workers/confirmations',
    passwords: 'workers/passwords',
  }
  resources :workers, only: [:show]

  #メンバーアカウント
  devise_for :members, controllers: {
    registrations: 'members/registrations',
    sessions: 'members/sessions',
    confirmations: 'members/confirmations',
    passwords: 'members/passwords',
  }

  resources :members, only: [:show]

  root to: 'lists#index' #トップページ
  #各種LPページ
  get 'guide' => 'top#guide' #企業側LP
  #特集
  get 'special' => 'top#special'
  get 'faq' => 'top#faq'
  get 'co' => 'top#co'

  #企業側アカウント
  get 'companies/pay' => 'companies#pay'

  resources :companies do
    collection do
      get :pay
      post :get_point
      post :confirm
      post :thanks
    end
  end

  #記事一覧
  resources :posts
  #LPページ
  resources :lps
  #企業HP一覧
  resources :lists do
    collection do
      post :import
    end
    resources :comments, :recruits, :seos
  end

  resources :mailers

  resources :matters

  resources :estimates do
    collection do
      post :confirm
      post :thanks
    end
  end
  #問い合わせフォーム
  get '/contact' => 'contact#index'
  post '/confirm' => 'contact#confirm'
  post '/thanks' => 'contact#thanks'

  get '*path', controller: 'application', action: 'render_404'
end
