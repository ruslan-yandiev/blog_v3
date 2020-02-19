class Tag < ApplicationRecord
  # создаем связи между моделями многие ко многим (связи в бд) через третью таблицу в БД taggings
  has_many :taggings
  has_many :posts, through: :taggings

  def self.counts
    select("name, count(taggings.tag_id) as count").joins(:taggings).group("name, taggings.tag_id")
  end
end
