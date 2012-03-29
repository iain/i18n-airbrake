# I18n::Airbrake

* translates known keys normally
* translates defaults normally
* notifies airbrake in production environment
* titleizes the key in production environment
* raises the error in development environment
* raises the error in test environment

(straight from the specs)

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'i18n-airbrake'
```

And then execute:

``` shell
$ bundle
```

## Usage

That should be it. There is no configuration (yet).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
