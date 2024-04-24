`Heroku open` to deploy
https://salty-retreat-39771-4e5699d91b7d.herokuapp.com/

## I am proud of myself for:
- My determination and focus in this project.  
  - I honestly didn't think I could do this and I was proud to say I kept chugging along one elephant bite at a time. 
- Deploying solo for the first time. I've never actually had hands on in any of the deployments up to this point.  
- When I ran into trouble that I eventually had to ask help for, I was always on the right track.  My logic and approach were sound.  It was usually syntactical things that got in the way.  
- How I learned to sit with the problems without being able to ask for help
  - this grew my resourcefulness and I practiced the things I thought I was already practicing: rubber ducking, whiteboarding, actually TRYING things without knowing the end result or how it would play out.  I let it get messy.  
  - These are all things we knew but I hadn't experienced them to the point I did in this project and it was invaluable to be made to slow down and look at it myself instead of reaching for help the fisrt or second thing. 
## DEPLOYMENT: 
- This is the first time I have hands-on deployed.  This was a win for me.

- Missed Procfile the first go around on deployment
- I was able to deploy the app on heroku but could not figure out how to get to any pages after initial deployment.  

    - I tried looking at heroku logs --tail but struggled deciphering it.  This was one error I could see but I do, in fact have that route. 
 (No route matches [GET] "/merchants/1/coupons"): (No route matches [GET] "/merchants/1/coupons")
   - I tried using forward slashes with the path I wanted to follow like it said online but it just said: 
`The page you were looking for doesn't exist.
You may have mistyped the address or the page may have moved.`


## ERRORS
### No coupon connected to invoice/show
- Per screenshot in file below README.md: I was running into this error on localhost http://localhost:3000/merchants/1/coupons/1.
- I thought seeding data would be enough but that didn't work.
- I tried to manually input coupons in localhost then activate them. That worked temporarily
- I then created a CSV file with my coupons, imported the objects I had created, added a header, created a code block for Coupons in lib/tasks/csv_load.rake then ordered it behind Merchants in the `task :all do` method at the end.  The load actually WORKED (huge win) after a lot of finagling however, it did not solve my problem.  I still don't know where this error is coming from. 
- Pry returns a coupon in the model and feature tests but not the view
- seeds.destroy_all in seed file
- destroy all for each table in the csv_load file
- Added :status to #invoice_params

### model method errors in invoices and customers
- Played around with all sorts of relational changes in spec objects
- tried to utilize pluck in AR methods
- 

## PLACES TO REFACTOR
- I'm curious if there is a better, more efficient way to do US 7 logic.  I used ruby and utilized a helper method for readability.  
- I would love to try styling at some point.  I actually think I may like it more. As it is, I stuck to trying to tidy up my logic.  


## QUESTIONS
1. ruby on calculations.  Can they be refactored?
2. CSV load in trying to troubleshoot needing to load coupons manually on local host. Did I need to do that since I already instantiated them locally?
3. Good process in checking functionality through steps of save_and_open_page => localhost => deployment.  
4. Can I do one conditional with two sad paths?  Or should I group them with a more vague error message? US2 sad paths.  

## LEARNED
1. Be diligent about adding and committing with detailed commit messages.  I thought I would knowk where I was at when I was making those commits.  I need more detail than even that and to commit more often.  
2. I do know this stuff.  When I had errors that I was working on for a while and asked for help, I found that I was on track all along, it was mostly just syntactical errors but I was always close to what I needed. eg: ruby over AR in my calculations
3. I do like this when I know what I'm doing
4. I do better when I calm down.  The stress of timelines has been my downfall here.  If I can slow down, I work on sitting with the problem and getting messy with it to work through it.  Coming from a production background I was always waiting to know what to do before attempting which means I didn't attempt much before asking for help.  I need to get messy with it.  
5. Section and div classes in spp/views/merchant_coupons/index.html.erb.  
  - section above and below loop.  div below beginning and end of loop
  - Header below the section and above the loop

## AR Attempts
1. SELECT coupons.coupon_type,    #made alias's for each of these for readability in table
          coupons.amount, 
          coupons.id, 
          invoice_items.unit_price, 
          invoice_items.quantity
from coupons
join invoices
on coupons.id = invoices.coupon_id
join invoice_items
on invoices.id = invoice_items.invoice_id
where(invoice_items.sum(unit_price * quantity));


ERROR:  schema "invoice_items" does not exist
LINE 7: where(invoice_items.sum(unit_price * quantity));
              ^



## Evaluation
Problems and how solved: no coupons on localhost: added manually due to lack of csvload coupons. then added csv. 

Please prepare the flow of your presentation in advance.

need to do:
- walk through 
  - coupon crud functionality
  - overall revenue change on merchant and admin invoice show pages
- second sad path
- if a coupon exceeds the total revenue, revenue doesn't go lower than zero. 



1. merchant dashboard http://localhost:3000/merchants/1/dashboard
2. merchant coupon create http://localhost:3000/merchants/1/coupons
3. merchant coupon deactivate http://localhost:3000/merchants/1/coupons/1
4. merchant coupon activate
5. 
6. merchant coupons index (sorted) http://localhost:3000/merchants/1/coupons
7. merchant invoice show http://localhost:3000/merchants/1/
8. admin invoice show http://localhost:3000/admin/invoices/1


http://localhost:3000/admin/invoices





