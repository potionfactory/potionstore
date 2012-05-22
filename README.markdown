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

- Rails 3.0 or higher.
- PostgreSQL or MySQL


Installation
------------

This is a brief outline of the steps required to get the development environment of Potion Store up
and running on your local machine.

- Install gems via Bundler
  - Run ```bundle install```

- Edit the following config files to suit your needs

  - config/store.yml
  - config/paypal.yml
  - config/google_checkout.yml

- Create config/google_checkout.yml. Modify it with your credentials.
  ```
  # Settings for Google Checkout

  # Get these by logging into Google Checkout's merchant site and the sandbox equivalent

  development:
    gcheckout_merchant_id: "XXXXXXXXXXXXXXX"
    gcheckout_merchant_key: "XXXXXXXXXXXXXXXXXXXXXX"

  test:
    gcheckout_merchant_id: "XXXXXXXXXXXXXXX"
    gcheckout_merchant_key: "XXXXXXXXXXXXXXXXXXXXXX"

  production:
    gcheckout_merchant_id: "XXXXXXXXXXXXXXX"
    gcheckout_merchant_key: "XXXXXXXXXXXXXXXXXXXXXX"
  ```
  
- Create config/paypal.yml. Modify it with your credentials.
  ```
  # PayPal API Access Setup
  #
  # Instructions:
  #
  # 1. Go to https://developer.paypal.com/.
  # 2. Create an account if you don't have one.
  # 3. Click the "Test Accounts" on the left sidebar.
  # 4. Create a Business Test Account if you don't have one.
  # 5. Select the Business Test Account and click the "Enter Sandbox Test Site" button.
  # 6. Once you log in, click "Profile."
  # 7. Click on "API Access."
  # 8. Click the "Request API Credentials" link.
  # 9. Leave the default selection on "Request API signature" and click the "Agree and Submit" button.
  # 10. Fill in api_username and api_password and api_signature with the given information.

  # Development settings
  development:
    pi_username: "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    api_password: "XXXXXXXXXXXXXXXX"
    api_signature: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    wiredump: true # Turn on logging of communications with PayPal during development

  # Follow steps 6 to 10 but with your real PayPal account.
  # NOTE: Your PayPal account must have Website Payments Pro already for this to work.

  # Live settings
  production:
    api_username: "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    api_password: "XXXXXXXXXXXXXXXX"
    api_signature: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    # Don't turn this on in production mode unless you absolutely have to. It'll log people's credit card information
    wiredump: false 

  # Common setting
  # NOTE: This file is already provided for you. You don't need to download it again.
  ca_file: "certs/api_cert_chain.crt"
  ```
- Set session store secret
  Edit config/environment.rb and modify the config.action_controller.session setting

- Setup database
  - Install Postgresql or MySQL if you haven't
  - Create the store_development database.
  	Make sure to set the encoding of the database to UTF8.
	I recommend pgAdmin for Postgresql newcomers.
  - Edit config/database.yml
  - run "rake db:migrate" to create the database schema
   
- Run ```rails s``` and test through
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

1. ```gem install ruby-debug```
2. Put 'debugger' where you want to break in your source code
3. Start the app with ```rails s --debugger``` to enable breakpoints

  
Final Notes
-----------

I'd appreciate it if you kept the "Powered by Potion Store" link in the footer. It'll help more developers find the project.
