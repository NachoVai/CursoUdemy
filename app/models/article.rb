class Article < ApplicationRecord
	include PermissionsConcern
	has_many :has_categories, dependent: :destroy
	has_many :categories, through: :has_categories
	after_create :save_categories
	belongs_to :user
	validates :title, :body, uniqueness: true
	validates :title, length: { in: 5..25 }
	validates :body, length: { minimum: 50, too_short: "Minimo son %{count} carácteres." }
	scope :ultimos, -> {order("created_at DESC")}

	scope :titulo, -> (title) { where("title LIKE ?", "#{title}%")}

	def categories=(value)
		@categories = value
	end

	private
	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end
end
