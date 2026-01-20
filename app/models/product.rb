class Product < ApplicationRecord
  # Action Text for rich text description
  has_rich_text :description
  # Active Storage for product images
  has_one_attached :product_image

  # One to Many Relationship with Transaction model
  has_many :transactions, dependent: :destroy

  scope :search, ->(query) {
    if query.present?
      where(
        "LOWER(name) LIKE :q",
        q: "%#{query.downcase}%"
      )
    end
  }

  def low_stock?
    quantity < 10
  end
end
