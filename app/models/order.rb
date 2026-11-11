class Order < ApplicationRecord
  STATUSES = %w[new paid shipped].freeze

  belongs_to :customer
  belongs_to :province
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  attribute :status, :string, default: "new"

  validates :order_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: STATUSES }
  validates :subtotal, :total, :gst_amount, :pst_amount, :hst_amount,
            numericality: { greater_than_or_equal_to: 0 }
end
