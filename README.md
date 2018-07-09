# Hocsv

HOCSV is a Ruby gem that converts an array of hashes to a CSV file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hocsv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hocsv

## Usage
### Create an instance on Hocsv passing in your data and a filename(optional - will default to hocsv.csv) and save it to a local variable :

```
	example_ary = [{one:1}, {two:2}]
```
```
	hocsv = Hocsv.new(example_ary, ‘example_file)
```

### To create a file and covert your data call `#to_hocsv` on your hocsv instance
```
	hocsv.to_csv
```

Note: Your file will be saved in the current directory with the provided or default filename ending in  **.csv**

## Development
####Ruby Version: 2.3.3
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hocsv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hocsv project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[tyrantdavis]/hocsv/blob/master/CODE_OF_CONDUCT.md).
