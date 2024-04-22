# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke
@merchant1 = Merchant.create!(name: "Hair Care")
@merchant2 = Merchant.create!(name: "Jewelry")

@item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
@item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
@item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
@item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
@item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
@item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

@item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
@item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

@customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
@customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
@customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
@customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
@customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
@customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
@invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
@invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
@invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
@invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
@invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
@invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

@invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 2)

@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
@ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
@ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
@ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
@ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
@ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
@ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
@ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
@ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)

@transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
@transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
@transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
@transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
@transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
@transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
@transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
@transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)


#Status: activated
@coupon1 = @merchant1.coupons.create!(name: "Buy one get one free", status: 1, code: "BOGO", amount: 50.0, coupon_type: "%")
@coupon2 = @merchant1.coupons.create!(name: "Ten Dollars off", status: 1, code: "10OFF", amount: 10, coupon_type: "dollars")
@coupon3 = @merchant1.coupons.create!(name: "Twenty Five Percent", status: 1, code: "25%OFF", amount: 25.0, coupon_type: "%")
@coupon4 = @merchant1.coupons.create!(name: "Twenty Percent", status: 1, code: "20%OFF", amount: 20.0, coupon_type: "%")

#Status: deactivated
@coupon5 = @merchant1.coupons.create!(name: "Five dollars", code: "5OFF", amount: 5, coupon_type: "dollars") 
@coupon6 = @merchant1.coupons.create!(name: "Twenty Dollars off", code: "20OFF", amount: 20, coupon_type: "dollars") 