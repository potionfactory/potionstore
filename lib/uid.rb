require 'securerandom'

def uid()
  chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  uid = ''
  for i in 0..15 do
    uid << chars[SecureRandom.random_number(chars.length), 1]
  end
  return uid
end

