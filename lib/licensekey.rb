#!/usr/bin/env ruby
#
# Modify this file and put in your own license key generator
#

def random_chars_of_length(len)
  chars = ("A".."Z").to_a + ("0".."9").to_a
  result = ""
  1.upto(len) { |i| result << chars[rand(chars.size-1)] }
  return result
end

def make_license(product_code, name, copies)
  license = product_code.upcase() + '-' + random_chars_of_length(16)
  return license
end

# Simple command line test
if __FILE__ == $0
  puts make_license('tgr', 'Andy Kim', 1)
end
