class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :restrict_with_error

  validates :first_name, :last_name, :address_line, :city, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :postal_code, presence: true,
            format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must be a valid Canadian postal code" }
  validates :phone, format: { with: /\A[0-9 ()+.-]*\z/ }, allow_blank: true
end
