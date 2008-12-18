# Methods added to this helper will be available to all templates in the application.
def load_country_names()
  app_root = File.dirname(__FILE__) + '/../..'
  config_dir = app_root + '/config/'
  ymlpath = File.expand_path(config_dir + 'countries.yml')
  $COUNTRY_NAMES = YAML.load(File.open(ymlpath))
end

load_country_names()

module ApplicationHelper
  def country_name(country_code)
    return $COUNTRY_NAMES[country_code]
  end
end
