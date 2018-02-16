# Todoable

A minimal API wrapper around the Todoable API


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todoable', :git => 'https://github.com/fraczles/todoable'
```

And then execute:

    $ bundle

Or clone this repository and run:

```bash
$ gem build todoable.gemspec
$ gem install todoable-0.1.0.gem
```

Verify if it worked in irb:
```ruby
irb> require 'todoable'
=> true
```

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
### Routes
Here are a list of supported routes:

| Endpoint| Description | Method | Args | Example | 
| ------- |:------------| :------| ---: | ------- | 
| `GET /lists`  | Get all lists | `Todoable::Client#all_lists`   |     | `client.all_lists`|
| `POST /lists` | Create a list | `Todoable::Client#create_list` | `name`| `client.create_list(name: 'Chores')` | 
| `GET /lists/:id` | Get specified list| `Todoable::Client#get_list` | `list_id` | `client.get_list(list_id: '123')` | 
| `PATCH /lists/:id` | Edit a specific list| `Todoable::Client#edit_list` | `list_id`, `name` | `client.edit_list(list_id: 123, name: 'Laundry')`|
| `DELETE /lists/:id` | Delete a list | `Todoable::Client#delete_list` | `list_id` | `client.delete_list(list_id: 123)` | 
| `POST /lists/:id/items` | Add an item to a list| `Todoable::Client#create_item` | `list_id`, `name`| `client.add_item(list_id: 123, name: 'Fold clothes')`| 
| `PUT /lists/:id/items/:id/finish` | Mark an item as done | `Todoable::Client#finish_item` | `list_id`, `item_id`| `client.finish_item(list_id: 123, item_id: 456)`| 
| `DELETE /lists/:id/items/:id` | Delete an item | `Todoable::Client#delete_item` | `list_id`, `item_id`| `client.delete_item(list_id: 123, item_id: 456)`|





### Tips
Note that each route returns an [HTTParty::Response](http://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/Response)
instance.

If you're only interested in the data returned by the API call, use `JSON.parse`:

```ruby
irb> client = Todoable::Client.new
irb> # Ugly string
irb> pry(main)> client.all_lists
=> "{\"lists\":[{\"name\":\"Clean up\",\"src\":\"http://todoable.teachable.tech/api/lists/1e80718c-c92f-49e7-8799-4fc4ba02b4ad\",\"id\":\"1e80718c-c92f-49e7-8799-4fc4ba02b4ad\"},{\"name\":\"Chores\",\"src\":\"http://todoable.teachable.tech/api/lists/b889f1c5-9e34-476f-980f-29eb5a151c92\",\"id\":\"b889f1c5-9e34-476f-980f-29eb5a151c92\"}]}"
irb> # Nicer hash
irb> JSON.parse(client.all_lists)
=> {"lists"=>
  [{"name"=>"Clean up", "src"=>"http://todoable.teachable.tech/api/lists/1e80718c-c92f-49e7-8799-4fc4ba02b4ad", "id"=>"1e80718c-c92f-49e7-8799-4fc4ba02b4ad"},
   {"name"=>"Chores", "src"=>"http://todoable.teachable.tech/api/lists/b889f1c5-9e34-476f-980f-29eb5a151c92", "id"=>"b889f1c5-9e34-476f-980f-29eb5a151c92"}]}
```
