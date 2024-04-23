class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
  
  def discount_in_dollars_for_perentage_coupon
    total_revenue * (coupon.amount / 100)
  end

  def rev_after_coupons
    if coupon.coupon_type == "dollars"
      total_revenue - coupon.amount
    else
      total_revenue - self.discount_in_dollars_for_perentage_coupon
    end
  end

end
