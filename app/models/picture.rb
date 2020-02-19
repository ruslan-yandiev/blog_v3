class Picture < ApplicationRecord
  #добавили возможность загружать изображение
  mount_uploader :image, ImageUploader
end
