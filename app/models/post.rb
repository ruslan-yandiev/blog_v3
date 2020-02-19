class Post < ApplicationRecord
  #добавили возможность загружать изображение
  mount_uploader :image, ImageUploader
  validates :title, :summary, :body, presence: true
end
