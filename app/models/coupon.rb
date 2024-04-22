class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  enum status: ["deactivated", "activated"]

  def successful_times_used
    transactions.success.count
  end
end