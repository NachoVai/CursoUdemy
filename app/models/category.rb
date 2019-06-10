class Category < ApplicationRecord
    has_many :has_categories, dependent: :destroy
    has_many :articles, through: :has_categories
    belongs_to :user
    validates :name, :color, presence: true
    validates :name, length: { in: 7..10 }
    validates :color, length: { in: 4..7 }
end
