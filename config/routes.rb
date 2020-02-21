Rails.application.routes.draw do
  # мы указали, чтобы стартовой страницей в корневой директории выводился через контролер posts и экшен который будет вызываться по умолчанию: index
  root 'posts#index'
  # команда создает за нас несколько маршрутов для нашего контролера
  resources :posts
  # создаем маршруты для контролера, но так как у нас только два метода(экшена) создадим только для них маршруты
  resources :pictures, only: [:create, :destroy]
  # создадим маршрут для контроллера tags для вывода тегов для экшена show 
  resources :tags, only: [:show]

  resources :categories
end
