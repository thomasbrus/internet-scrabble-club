# Internet Scrabble Club

Ruby client for interacting with the [Internet Scrabble Club](http://www.isc.ro) servers.

## Example

```ruby
require 'internet_scrabble_club'

client = InternetScrabbleClub::Client.new

client.authenticate('nickname', 'password') do |login|
  # Authenticated ...
  puts login.greeting # => "Welcome to the Internet Scrabble Club, <nickname>"

  # Fetch history (last ten games)
  client.send_message('HISTORY', 'thomas92') do |history|
    puts history.entries.first # => #<OpenStruct index=1, first_player="thomas92" ... >
  end
end
```
