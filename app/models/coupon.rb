class Coupon < ActiveRecord::Base
  def initialize
    super()
    self.coupon = random_string_of_length(16).upcase
    self.used_count = 0
    self.use_limit = 1
  end

  def expired?
    (self.used_count >= self.use_limit) || (self.numdays != 0 && self.creation_time + self.numdays.days < Time.now)
  end
    
  private
  def random_string_of_length(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    s = ""
    1.upto(len) { |i| s << chars[rand(chars.size-1)] }
    return s
  end

end
