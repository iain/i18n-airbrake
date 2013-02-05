# I18n::Airbrake

* when the translation can be found
  *  translates normally
  *  uses the default normally
*  when the translation cannot be found
  *  development environment
     * does not notify airbrake
     * raises the error
  *  test environment
     * does not notify airbrake
     * raises the error
  *  production environment
     * does not titleize the key when the string does not responds_to?(:titleize)
     * titleizes the key when the string responds_to?(:titleize)
     * notifies airbrake
     * does not raise the error

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

## Configuration

The `handler` passed to the Proc is the instance of I18n::Airbrake::Handler that is handling the current invocation of I18n.translate

### Default

``` ruby
Airbrake.configure do |config|
  config.fail_when    = Proc.new do |handler|
    %w( development test ).include?(Rails.env)
  end
  config.notify_when  = nil
end
```

### Customization

``` ruby
I18n::Airbrake.configure do |config|
  config.fail_when = Proc.new do |handler|
    # Allow fallback to default plural rules
    handler.exception.is_a?(MissingTranslation) && handler.key.to_s != 'i18n.plural.rule'
  end

  config.notify_when = Proc.new do |handler|
    # Do not Notify in development or test
    %w( development test ).include?(Rails.env)
  end
end
```

## Usage

That should be it.

## Compatibility

Reported to be compatible with (and report missing translation errors in):

| other gem | version | since I18n::Airbrake version |
|---------- | ------- | ---------------------------- |
| rails     | 3.2.11  | 0.0.2 |
| rails_admin | 0.4.3 | master@HEAD |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
