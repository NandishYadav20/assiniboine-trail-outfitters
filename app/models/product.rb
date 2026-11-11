class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :restrict_with_error
  has_one_attached :image

  attribute :active, :boolean, default: true

  validates :name, :description, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :available, -> { where(active: true) }
  scope :in_category, ->(id) { where(category_id: id) if id.present? }
  scope :keyword, lambda { |q|
    if q.present?
      where("LOWER(products.name) LIKE :q OR LOWER(products.description) LIKE :q", q: "%#{q.to_s.downcase}%")
    end
  }
end
