# RagicClient

RagicClient is a simple tool integrate with [Ragic System](https://ragic.com). It's free and quite easy to use :smile: .

[Ragic HTTP API Integration Guide](https://www.ragic.com/intl/en/doc-api).

# Features

**[Create Entry](#create-entry)**
**[Update Entry](#update-entry)**
**[Delete Entry](#delete-entry)**
**[Find Entry By ID](#find-entry-by-id)**
**[Find Entry By Field ID And Value](#find-entry-by-field-id-and-value)**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ragic_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ragic_client

## Usage

### Config

First thing you need to set up is placing something like this either in initializer or in application.rb file:

```ruby
  RagicClient.config do |config|
    config.ragic_api_url = 'your ragic_api_url'
    config.ragic_api_key = 'Basic your_ragic_api_key'
  end
```

**Note: What you need to do is use the field ids of the fields as name, and the values that you want to insert as parameter values.**

See here [Ragic API Documents](https://www.ragic.com/intl/en/doc-api/15/Creating-a-New-Entry).

### Create Entry

```ruby
  params = {
    '1000001' => 'Project Name',
    '1000002' => '15000'
  }
  RagicClient.create params
```

### Update Entry

```ruby
  ragic_id = 1
  params = {
    '1000001' => 'Project Name Update'
  }
  RagicClient.update ragic_id, params
```

### Delete Entry

```ruby
  RagicClient.delete 1
```

### Find Entry by id

```ruby
  RagicClient.find 1
```

### Find Entry by field id and value

```ruby
  RagicClient.find_by { '1000001' => 'Project Name' }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/email_detected. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EmailDetected project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ragic_client/blob/master/CODE_OF_CONDUCT.md).