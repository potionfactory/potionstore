require 'google4r/checkout'

$GCHECKOUT_FRONTEND = nil

class TaxTableFactory
  def effective_tax_tables_at(time)

    tax_free_table = Google4R::Checkout::TaxTable.new(false)
    tax_free_table.name = "default table"
    tax_free_table.create_rule do |rule|
      rule.area = Google4R::Checkout::UsCountryArea.new(Google4R::Checkout::UsCountryArea::ALL)
      rule.rate = 0.0
    end
    return [tax_free_table]
  end
end

def _initialize_frontend
  environment = ENV['RAILS_ENV'] || 'production'
  live = (environment == 'production')

  app_root = File.dirname(__FILE__) + '/../../..'
  config_dir = app_root + '/config'

  prefs = File.expand_path(config_dir + '/google_checkout.yml')
  if File.exists?(prefs)
    y = YAML.load(File.open(prefs))
    y.each {|pref, value| eval("@#{pref} =\"#{value}\"")}
    y[environment].each {|pref, value| eval("@#{pref} =\"#{value}\"")}
  end

  $GCHECKOUT_FRONTEND = Google4R::Checkout::Frontend.new(:merchant_id => @gcheckout_merchant_id,
                                                          :merchant_key => @gcheckout_merchant_key,
                                                          :use_sandbox => environment != 'production')

  $GCHECKOUT_FRONTEND.tax_table_factory = TaxTableFactory.new
end



_initialize_frontend()
