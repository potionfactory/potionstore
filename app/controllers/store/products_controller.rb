class Store::ProductsController < ApplicationController
  layout "store"

  # GET /products
  # GET /products.xml
  # GET /products.json
  def index
    @products = Product.find(:all, :conditions => {:active => 1 })

    respond_to do |format|
      format.html # index.rhtml
      format.json { render :json => @products.to_json }
      format.xml  { render :xml => @products.to_xml }
    end
  end

end
