Magic Attributes
================

Magic Attributes is a quick way of defining a bunch of methods that do simple tasks like getting values of associated objects or simple operations that can be defined in a small block. Can be with Rails or plain old Ruby.

```ruby
class User < ActiveRecord::Base
  has_many :posts
  include MagicAttributes
  
  magic_attributes(last_post_created_at: [:posts, :last, :created_at],
                   full_name: -> (user) {"#{user.first_name} #{user.last_name}}
                  )

end

user = User.create(first_name: 'Bob', last_name: 'Ross' )

puts user.full_name # will be "Bob Ross"
puts user.last_post_created_at # is equivalent to user.posts.last.created_at

```

If you want even more magic please fork, add some abracadabra, make a test, and create a pull request.

