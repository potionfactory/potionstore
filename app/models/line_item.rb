require 'licensekey'

class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_numericality_of :quantity
  validates_numericality_of :unit_price

  def total
    return round_money(quantity * self.unit_price)
  end

  def volume_price
    # This is hard coded for now. Modify to suit your needs
    if self.product.code == 'pcm'
      return 19.95 if quantity >= 20
      return 22.95 if quantity >= 10
      return 24.95 if quantity >= 2
    elsif self.product.code == 'vc'
      return 9.95 if self.order.has_item_with_code('tgr')
    end
    return unit_price
  end

  def regular_price
    return product.price
  end

  def generate_license_key
    return make_license(self.product.code, self.order.licensee_name, self.quantity)
  end
    
end
