# Todoable

A minimal API wrapper around the Todoable API


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todoable', :git => 'https://github.com/fraczles/todoable'
```

And then execute:

    $ bundle

## Usage

### Configuration
When initializing a client, either pass in credentials directly:
```ruby
irb> require 'bundler/setup'
=> true
irb> require 'todoable'
=> true
irb> client = Todoable::Client.new(username: 'alex', password: '123')
=> #<Todoable::Client:0x00007fe94c306af0 @auth={:username=>"alex", :password=>"123"}>
```

or store them in your environment:
```bash
$ export TODOABLE_USERNAME='alex'
$ export TODOABLE_PASSWORD='123'
```

```ruby 
irb> client = Todoable::Client.new
=> #<Todoable::Client:0x00007fe94c306af0 @auth={:username=>"alex", :password=>"123"}>
```
