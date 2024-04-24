Missed Procfile the first go around on deployment


`Heroku open` to deploy

Per screenshot in file below README.md: I was running into this error on localhost http://localhost:3000/merchants/1/coupons/1.
- I had to manually input coupons then activate them.
- I thought seeding data would be enough but that didn't work.
- I then created a CSV file with my coupons, imported the objects I had created, added a header, created a code block for Coupons in lib/tasks/csv_load.rake then ordered it behind Merchants in the `task :all do` method at the end.  The load actually WORKED (huge win) after a lot of finagling however, it did not solve my problem.  I still don't know where this error is coming from. 
- Pry returns a coupon in the model and feature tests