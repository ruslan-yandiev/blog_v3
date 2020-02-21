class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true

  has_ancestry
end
