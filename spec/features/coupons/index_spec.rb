require 'rails_helper'

RSpec.describe 'coupon index page', type: :feature do
  describe 'US1' do
    describe 'as a merchant, when I visit dashboard_merchant_path' do
      before(:each) do
        @merchant1 = Merchant.create!(name: "Hair Care")

        @coupon1 = @merchant1.coupons.create!(name: "Buy one get one free", status: 1, code: "BOGO", amount: 50.0, coupon_type: "%")
        @coupon2 = @merchant1.coupons.create!(name: "Ten Dollars off", status: 1, code: "10OFF", amount: 10, coupon_type: "dollars")
        @coupon3 = @merchant1.coupons.create!(name: "Twenty Five Percent", status: 1, code: "25%OFF", amount: 25.0, coupon_type: "%")
        @coupon4 = @merchant1.coupons.create!(name: "Twenty Percent", status: 1, code: "20%OFF", amount: 20.0, coupon_type: "%")
        @coupon5 = @merchant1.coupons.create!(name: "Five dollars", code: "5OFF", amount: 5, coupon_type: "dollars")
        @coupon6 = @merchant1.coupons.create!(name: "Twenty Dollars off", code: "20OFF", amount: 20, coupon_type: "dollars")

        visit merchant_coupons_path(@merchant1)
      end

      it 'displays link to create a new coupon' do
        expect(page).not_to have_content("My favorite coupon idea")

        expect(page).to have_link("Create Coupon")
        click_link("Create Coupon")
        expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
        # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
        fill_in :name, with: 'My favorite coupon idea'
        fill_in :code, with: 'Some clever marketing'
        fill_in :amount, with: 6
        select "Dollars", from: "coupon_type"

        # And click the Submit button
        click_on "Create Coupon"

        # I'm taken back to the coupon index page 
        expect(current_path).to eq(merchant_coupons_path(@merchant1))

        # And I can see my new coupon listed.
        expect(page).to have_content("My favorite coupon idea")
      
        # * Sad Paths to consider: 
        # 1. This Merchant already has 5 active coupons
        # 2. Coupon code entered is NOT unique

      end

      it "displays flash message if I have 5 or more activated coupons" do
        @coupon5 = @merchant1.coupons.create!(name: "Five dollars", code: "5OFF", status: 1, amount: 5, coupon_type: "dollars")
        expect(page).not_to have_content("My favorite coupon idea")

        expect(page).to have_link("Create Coupon")
        click_link("Create Coupon")
        expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
        # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
        fill_in :name, with: 'My favorite coupon idea'
        fill_in :code, with: 'Some clever marketing'
        fill_in :amount, with: 6
        select "Dollars", from: "coupon_type"

        # And click the Submit button
        click_on "Create Coupon"

        # I'm taken back to the coupon index page 
        expect(page).to have_content("Error: Too many activated coupons to add one more")
        # And I can see my new coupon listed.
        expect(page).not_to have_content("My favorite coupon idea")
      end

      it "has sections for activated and deactivated coupons" do
        within '.activated' do
          save_and_open_page
          expect(page).to have_content(@coupon1.name)
          expect(page).to have_content(@coupon2.name)
          expect(page).to have_content(@coupon3.name)
          expect(page).to have_content(@coupon4.name)
        end
        within '.deactivated' do
          expect(page).to have_content(@coupon5.name)
          expect(page).to have_content(@coupon6.name)
        end
      end
    end 
  end
end