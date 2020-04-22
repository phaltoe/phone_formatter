# Phone Number Formatter

Phone Number Formatter is a simple UK Mobile Phone Formatter written in Ruby which allow us to format the user phone number before it's sent to Twilio as it requires a proper format.

 This program allows the user to input their phone numbers starting with:
 ```
 +44, 44, 0 or 7
 ```
 

If it starts with: `+44, 44, 0` it has to be followed by `7` and `9 digits`. If those conditions are met the phone is valid. Otherwise an Error will be thrown.

## How To Run The Program

    cd into the project
    bundle install
    rspec
    if you like to test some cases yourself, I left on lib/formatter.rb a bunch of scenarios commented out. Just comment in and run ruby lib/formatter.rb
    

## Walkthrough 

#### Basically we have some Regex matchers which will scan the number input and format it accordingly.

```ruby
module  Formatter
	module  PhoneNumber
		module  UK
      VALID_PREFIX  =  /^(0|\+?44)(?:\s?|\s+)(?:7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
      VALID_CODE_PREFIX  =  /^(0|\+?44)/.freeze
      VALID_LEAD  =  /^(7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
      TWILIO_PREFIX  =  '+44'

      def  self.format(number)
        if number.match(VALID_PREFIX)
            number.gsub(VALID_CODE_PREFIX,  TWILIO_PREFIX).delete('  ')
        elsif number.match(VALID_LEAD)
            (TWILIO_PREFIX  + number).delete('  ')
        else
            raise  'Number Not Valid'
        end
      end
		end
	end
end
```

Let's walkthrough the Regex: 

```ruby
VALID_PREFIX  =  /^(0|\+?44)(?:\s?|\s+)(?:7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
```
`/^(0|\+?44)`This will check if the number input either start with `0` or `44` or `+44`. 
If it does, 
`(?:\s?|\s+)`validates any whitespace it may have after that and before the next digit. 
`(?:7)` checks if the next digit is a `7` as mobile phones in the UK starts with `7`.
`(?:\s?|\s+)` again we check for whitespace.
`(?:\s?|\s+)(?:\d\s?|\d\s+){9}$`this bit will check that after the `7` you can either have whitespaces or valid digits `0 to 9` and that it has exactly 9 digits. 
If all conditions are met this is a `VALID_PREFIX`

```ruby
VALID_LEAD  =  /^(7)(?:\s?|\s+)(?:\d\s?|\d\s+){9}$/.freeze
```

`VALID_LEAD` basically follows the same pattern as `VALID_PREFIX` but for inputs starting with `7`

```ruby
def  self.format(number)
	if number.match(VALID_PREFIX)
		number.gsub(VALID_CODE_PREFIX,  TWILIO_PREFIX).delete('  ')
	elsif number.match(VALID_LEAD)
		(TWILIO_PREFIX  + number).delete('  ')
	else
		raise  'Number Not Valid'
	end
end
```
`self.format(number)` is a method that will run the regex checkers and format accordingly to the returning matcher. Whether it's a `VALID_PREFIX`, `VALID_LEAD` or not a match at all which will raise an error Instead.

```ruby
puts Formatter::PhoneNumber::UK.format('+44  7  5 6 5 7   5 7 8 3 5 ') 
=> +447565757835
puts Formatter::PhoneNumber::UK.format('07355433344')
=> +447355433344

puts Formatter::PhoneNumber::UK.format('345465768787875856776885')
=>Traceback (most recent call last):
=>        1: from lib/formatter.rb:28:in `<main>'`
=>lib/formatter.rb:17:in `format': Number Not Valid (RuntimeError)`
```

## Implementation 
I decided to isolate the `7` from the prefix so this code could be easily extended if we needed to handle different cases without having to change the whole application. 

## Testing
I used `RSpec` for testing and covered those scenarios:
1) User can either have a number starting with `0, 7, 44, +44 `.
2) User can have `N` number of whitespaces after the prefix(`0, 7, 44, +44 `).
3) Valid numbers will have exactly `9` digits after prefix.
4) If numbers have more or less than `9` digits after prefix an error will be thrown.
5) If number is blank an error will be thrown.
6) If there is a not valid character an error will be thrown.


## Takeaways

While the test coverage cover all the lines, I am still not confident it will behave properly on every scenario. I tried to follow the requirements and for instance didn't implement any solution to handle whitespaces before the prefix. For the future, this could be implemented and the program could also be extended since current implementation is not coupled together. 


----

*Phone Number Formatter was created by Pedro Henrique Altoé on 22/04/2020.*