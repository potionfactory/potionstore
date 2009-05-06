Welcome to Potion Store
-----------------------

Features:

- PayPal Website Payments Pro support
- PayPal Express Checkout support
- Google Checkout support
- Administration interface with some simple sales charts
- Coupons
- Send lost license page (http://mycompany.com/store/lost_license)
- Google Analytics e-commerce transaction tracking support for PayPal and credit card orders


Dependencies
------------

- Rails 2.1 or higher.
- PostgreSQL or MySQL


Installation
------------

This is a brief outline of the steps required to get the development environment of Potion Store up
and running on your local machine.

- Edit the following config files to suit your needs

  - config/store.yml
  - config/paypal.yml
  - config/google_checkout.yml

- Set session store secret
  Edit config/environment.rb and modify the config.action_controller.session setting

- Setup database
  - Install Postgresql or MySQL if you haven't
  - Create the store_development database.
  	Make sure to set the encoding of the database to UTF8.
	I recommend pgAdmin for Postgresql newcomers.
  - Edit config/database.yml
  - run "rake db:migrate" to create the database schema
   
- Run script/server and test through
  <http://localhost:3000/store> and
  <http://localhost:3000/admin>

- Replace the default license key generator in lib/licensekey.rb with your own

- If you are setting up Google Checkout, log into your Google Checkout account (sandbox or live), go
  to Settings->Integration and put in your URL that corresponds to the following:

  https://secure.potionfactory.com/store/notification/gcheckout

  That is the URL that Google uses to make callbacks. If you don't set this up, your customers will
  not get their orders delivered by email.


Debugging
---------

1. gem install ruby-debug
2. Put 'debugger' where you want to break in your source code
3. Start the app with 'script/server --debugger' to enable breakpoints

  
Final Notes
-----------

I'd appreciate it if you kept the "Powered by Potion Store" link in the footer. It'll help more developers find the project.
