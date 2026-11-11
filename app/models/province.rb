class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  validates :name, :code, presence: true, uniqueness: true
  validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }

  # HST replaces GST + PST where it applies.
  def tax_breakdown(amount)
    if hst.to_d.positive?
      { "HST" => (amount * hst).round(2) }
    else
      { "GST" => (amount * gst).round(2), "PST" => (amount * pst).round(2) }
    end
  end
end
