class MerchantCouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])

    @coupon = Coupon.find(params[:id])
  end
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)

    if @merchant.activated_coupons_count < 5 # && unique
      @coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      flash[:error] = "Error: Too many activated coupons to add one more"
      redirect_to new_merchant_coupon_path(@merchant)
    end
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
    
    if params[:new_status]
      @coupon.update(status: params[:new_status])
      redirect_to merchant_coupon_path(@merchant, @coupon)
    end
  end


  private
  def coupon_params
    params.permit(:name, :code, :status, :amount, :coupon_type)
  end
end