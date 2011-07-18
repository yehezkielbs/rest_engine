rest_engine
===========

rest_engine is a Rails 3 engine that provide your Rails application a restful API

Installation
------------

In your `Gemfile`, add the following dependencies:

    gem 'rest_engine', :git => 'git://github.com/yehezkielbs/rest_engine.git'

Run:

    $ bundle install

That's it. It will provide a restful API for your models.

Usage
-----

Start the server:

    $ rails server

Let's say you have a model `Customer`, you should now be able to access your customers:

* To get a list of customers: `GET http://localhost:3000/api/customers`
* To get a single customer: `GET http://localhost:3000/api/customers/1`
* To create a new customer: `POST http://localhost:3000/api/customers`
* To update a customer: `PUT http://localhost:3000/api/customers/1`
* To delete a customer: `DELETE http://localhost:3000/api/customers/1`

It also support namespaced model. For example if your model is `Product::Toy`, then the url would be: `http://localhost:3000/api/product/toys`

Or, to see the available routes:

    $ rake routes

Contributing to rest_engine
---------------------------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 Yehezkiel Syamsuhadi. See LICENSE.txt for
further details.
