class Post < ApplicationRecord
  #добавили возможность загружать изображение
  mount_uploader :image, ImageUploader

  belongs_to :category

  # создаем связи между моделями многие ко многим (связи в бд) через третью таблицу в БД taggings
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, :summary, :body, presence: true

  # метод на получение всех тегов геттер
  def all_tags
  	tags.map(&:name).join(', ')
  end

  # метод сеттер ищет или создает тек если нет такого
  def all_tags=(names)
  	self.tags = names.split(',').map do |name| # возможно из-за того, что вызвали блок и нужно указать напрямую self
  	  Tag.where(name: name.strip).first_or_create!
  	end
  end
end
