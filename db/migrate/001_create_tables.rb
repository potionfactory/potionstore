class CreateTables < ActiveRecord::Migration
  def self.up

    create_table :products do |t|
      t.column "code",              :string,  :limit => 16,                                :default => "",  :null => false
      t.column "name",              :string,  :limit => 64,                                :default => "",  :null => false
      t.column "price",             :decimal,               :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.column "image_path",        :text
      t.column "url",               :text
      t.column "download_url",      :text
      t.column "license_url_scheme",:text
      t.column "active",            :integer,                                              :default => 1,   :null => false
    end

    create_table :coupons do |t|
      t.column "code",          :string,    :limit => 16,                                :default => "",  :null => false
      t.column "description",   :string,    :limit => 64,                                :default => "",  :null => false
      t.column "coupon",        :string,    :limit => 64,                                :default => "",  :null => false
      t.column "product_code",  :string,    :limit => 16,                                :default => "",  :null => false
      t.column "amount",        :decimal,                 :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.column "percentage",    :integer
      t.column "used_count",    :integer
      t.column "use_limit",     :integer,                                                :default => 1,   :null => false
      t.column "creation_time", :timestamp
      t.column "numdays",       :integer,                                                :default => 0,   :null => false
    end

    add_index "coupons", ["coupon"], :name => "coupon"

    create_table :orders do |t|
      t.column "coupon_id",          :integer
      t.column "status",             :string,   :limit => 1,   :default => "P", :null => false
      t.column "email",              :string,   :limit => 128, :default => "",  :null => false
      t.column "order_time",         :datetime
      t.column "first_name",         :string,   :limit => 64,  :default => ""
      t.column "licensee_name",      :string,   :limit => 128
      t.column "last_name",          :string,   :limit => 64,  :default => ""
      t.column "company",            :string,   :limit => 64
      t.column "address1",           :string,   :limit => 64,  :default => ""
      t.column "address2",           :string,   :limit => 64
      t.column "city",               :string,   :limit => 64,  :default => ""
      t.column "state",              :string,   :limit => 64,  :default => ""
      t.column "zipcode",            :string,   :limit => 64,  :default => ""
      t.column "country",            :string,   :limit => 2,   :default => "",  :null => false
      t.column "payment_type",       :string,   :limit => 16
      t.column "ccnum",              :string,   :limit => 32
      t.column "comment",            :text
      t.column "failure_code",       :integer
      t.column "failure_reason",     :string
      t.column "transaction_number", :string,   :limit => 64
    end

    add_index "orders", ["coupon_id"], :name => "coupon_id"
    add_index "orders", ["email"], :name => "email"
    
    create_table :line_items do |t|
      t.column "order_id",    :integer,                                              :default => 0,   :null => false
      t.column "product_id",  :integer,                                              :default => 0,   :null => false
      t.column "quantity",    :integer,                                              :default => 0,   :null => false
      t.column "unit_price",  :decimal,               :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.column "license_key", :string,  :limit => 64
    end

    add_index "line_items", ["order_id"], :name => "order_id"
    add_index "line_items", ["product_id"], :name => "product_id"

    create_table :list_subscribers do |t|
      t.column "email", :text, :default => "", :null => false
    end

    add_foreign_key_constraint "line_items", "order_id", "orders", "id", :on_update => nil, :on_delete => :cascade
    add_foreign_key_constraint "line_items", "product_id", "products", "id", :on_update => nil, :on_delete => nil

    add_foreign_key_constraint "orders", "coupon_id", "coupons", "id", :on_update => nil, :on_delete => :restrict

    p = Product.new
    p.code = "foo"
    p.name = "Footion v1"
    p.price = 12.95
    p.image_path = "/images/store/application_icon.png"
    p.url = "http://www.mycompany.com/foo/"
    p.download_url = "http://www.mycompany.com/foo/download/"
    p.license_url_scheme = "x-com-mycompany-license-footion"
    p.save()

    p = Product.new
    p.code = "bar"
    p.name = "Barsoap v1"
    p.price = 24.95
    p.url = "http://www.mycompany.com/bar/"
    p.image_path = "/images/store/application_icon.png"
    p.download_url = "http://www.mycompany.com/bar/download/"
    p.license_url_scheme = "x-com-mycompany-license-barsoap"
    p.save()
  end

  def self.down
    remove_foreign_key_constraint "line_items", "line_items_ibfk_order_id"
    remove_foreign_key_constraint "line_items", "line_items_ibfk_product_id"
    remove_foreign_key_constraint "orders", "orders_ibfk_coupon_id"
    
    drop_table :list_subscribers
    drop_table :line_items
    drop_table :orders
    drop_table :coupons
    drop_table :products
  end
end
