# OpenID::Store::Mongo

MongoDB store for ruby-openid

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-openid-store-mongo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-openid-store-mongo

## Usage

Initialize the store with a Mongo collection.  A TTL index will be created on the collection which will
automatically remove expired entries.  This requires a Mongo instance of 2.2 or greater.

    client = MongoClient.new('localhost', 27017)
    db     = client['sample-db']
    coll   = db['ruby_openid']
    OpenID::Store::Mongo.new(:collection => coll)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
