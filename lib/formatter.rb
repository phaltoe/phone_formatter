# frozen_string_literal: true

module Formatter
  module PhoneNumber
    module UK
      VALID_PREFIX = /^(0|\+?44)(?:\s?|\s+)(?:7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
      VALID_CODE_PREFIX = /^(0|\+?44)/.freeze
      VALID_LEAD = /^(7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
      TWILIO_PREFIX = '+44'

      def self.format(number)
        if number.match(VALID_PREFIX)
          number.gsub(VALID_CODE_PREFIX, TWILIO_PREFIX).delete(' ')
        elsif number.match(VALID_LEAD)
          (TWILIO_PREFIX + number).delete(' ')
        else
          raise 'Number Not Valid'
        end
      end
    end
  end
end

#THIS IS COMMENTED OUT IN CASE YOU WANT TO TEST SOME EDGE CASES

# puts 'VALID NUMBERS'
# puts Formatter::PhoneNumber::UK.format('447355605688')
# puts Formatter::PhoneNumber::UK.format('+447565757835')
# puts Formatter::PhoneNumber::UK.format('44 7565757835')
# puts Formatter::PhoneNumber::UK.format('447 565757835')
# puts Formatter::PhoneNumber::UK.format('+44  7  5 6 5 7 5   7 8 3 5 ')
# puts Formatter::PhoneNumber::UK.format('07355433344')
# puts Formatter::PhoneNumber::UK.format('7344567884')

# puts 'INVALID NUMBERS'
# puts Formatter::PhoneNumber::UK.format('02355433343')
# puts Formatter::PhoneNumber::UK.format('')
# puts Formatter::PhoneNumber::UK.format('33456')
# puts Formatter::PhoneNumber::UK.format('345465768787875856776885')
# puts Formatter::PhoneNumber::UK.format('+4402355433343')
