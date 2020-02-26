Rails.application.routes.draw do
  devise_for :users
  # мы указали, чтобы стартовой страницей в корневой директории выводился через контролер posts и экшен который будет вызываться по умолчанию: index
  root 'posts#index'
  
  # команда создает за нас несколько маршрутов для нашего контролера
  resources :posts, only: [:show, :index]

  # создадим маршрут для контроллера tags для вывода тегов для экшена show 
  resources :tags, only: [:show]

  resources :categories, only: [:show] # для всех пользователей кроме админа ограничели маршруты только экшеном show 

  # создаем пространство имен и сюда нам нужно поместить те маршруты которые мы хотим для администратора в его админ панели.
  namespace :admin do
    resources :categories, except: [:show] # указали маршрут к контролерру categories и его экшенам(методам) кроме экшена show
    resources :posts, except: [:show, :index]
    # создаем маршруты для контролера, но так как у нас только два метода(экшена) создадим только для них маршруты
    resources :pictures, only: [:create, :destroy]
  end
end

#Все это на DSL 