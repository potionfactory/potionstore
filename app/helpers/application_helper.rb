# Methods added to this helper will be available to all templates in the application.
def load_country_names()
  app_root = File.dirname(__FILE__) + '/../..'
  config_dir = app_root + '/config/'
  ymlpath = File.expand_path(config_dir + 'countries.yml')
  $COUNTRY_NAMES = YAML.load(File.open(ymlpath))
end

load_country_names()

# I know it's not good to make this method global, but I can't get the thankyou_plain.rhtml template to call it otherwise
def country_name(country_code)
  return $COUNTRY_NAMES[country_code]
end

module ApplicationHelper
  def country_name_and_code_pairs()
    pairs = []
    for pair in $COUNTRY_NAMES
      pairs << [pair[1], pair[0]]
    end
    pairs.sort! {|x,y| x[0] <=> y[0]}
    return pairs
  end
end
