require 'rails_helper'

RSpec.describe  'Coupon Show page', type: :feature do
  describe 'US3' do
    describe 'As a merchant when I visit merchant_coupon_path' do
      before(:each) do
        @merchant1 = Merchant.create!(name: "Hair Care")
        # @merchant2 = Merchant.create!(name: "Jewelry")

        @coupon1 = @merchant1.coupons.create!(name: "Buy one get one free", status: 1, code: "BOGO", amount: 50.0, coupon_type: "%")
        @coupon2 = @merchant1.coupons.create!(name: "Ten Dollars off", status: 0, code: "10OFF", amount: 10, coupon_type: "dollars")


        #Merchant1
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
        @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
        @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
        @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

        #Merchant2
        # @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
        # @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

        @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
        @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
        @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
        @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
        @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
        @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
        @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon_id: @coupon1.id)
        @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon_id: @coupon1.id)
        @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2, coupon_id: @coupon1.id)
        @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2, coupon_id: @coupon1.id) #failed transaction
        @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

        @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 2) #another customer_6

        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0) #pending
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)#shipped
        @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)#packaged
        @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
        @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)

        @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
        @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
        @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_7.id, quantity: 1, unit_price: 1, status: 1)

        @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
        @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
        @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
        @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
        @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
        @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)#failed 
        @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
        @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)
        

        visit merchant_coupon_path(@merchant1, @coupon1)
      end
      it 'displays percent/dollar of, status and count of how many times coupon has been used' do
        expect(page).to have_content(@coupon1.name)
        expect(page).to have_content(@coupon1.status)
        expect(page).to have_content("Coupon has been used 3 times")
      end

      it "displays activate button if status is deactivated" do
        # When I visit one of my active coupon's show pages
        visit merchant_coupon_path(@merchant1, @coupon1)
        expect(page).to have_content(@coupon1.name)

        # I see a button to deactivate that coupon
        expect(page).to have_button("Deactivate")
        # When I click that button

        click_button "Deactivate"

        # I'm taken back to the coupon show page 
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))

        # And I can see that its status is now listed as 'inactive'.
        expect(page).to have_button("Activate")
        expect(page).to have_content("deactivated")
      end

      it "displays deactivate button if status is activated" do
        visit merchant_coupon_path(@merchant1, @coupon2)
        expect(page).to have_content(@coupon2.name)

        expect(page).to have_button("Activate")
        click_button "Activate"  
        
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon2))
        
        expect(page).to have_button("Deactivate")
        expect(page).to have_content("activated")

      end
    end 
  end
end