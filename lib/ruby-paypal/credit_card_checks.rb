#
# Performs a series of credit card number checks.
#
module CreditCardChecks
  # Perform Luhn check on a credit card number. Refer to http://en.wikipedia.org/wiki/Luhn_algorithm
  #
  def luhn_check(number)
    num = 0
    number.length.times { |p|
        position = number.length - p - 1
      if position % 2 == 0 then
        doubled = number[position,1].to_i * 2
        if doubled > 9 then
          num = num + doubled.to_s[0,1].to_i +  doubled.to_s[1,1].to_i
        else
          num = num + doubled.to_i
        end
      else
        num = num + number[position,1].to_i
      end
    }
    if num.to_i % 10 == 0 then
      return true
    else
      return false
    end
  end

  # Perform checks on credit card numbers with reference to the length of the credit card number
  # and the type of credit card. Refer to http://en.wikipedia.org/wiki/Credit_card_number
  #
  def card_type_check(type, number)
    validity = false
    case type.upcase
      when "VISA"
        validity = true if (number.length == 16 or number.length = 13) and number[0,1] == "4"
      when "MASTERCARD"
        validity = true if (number.length == 16) and (52..55).include?(number[0,2].to_i)
      when "AMEX"
        validity = true if (number.length == 16) and ['34', '37'].include?(number[0,2])
      when "DISCOVER"
        validity = true if (number.length == 16) and (number[0,2] == "65" or number[0,4] == "6011")
      when "SWITCH"
        # TODO checks for Switch cards
        validity = true
      when "SOLO"
        # TODO checks for Solo cards
        validity = true
      else
        raise "Invalid card type entered"
    end

    return validity
  end



end