require "i18n"
require "i18n-airbrake/version"
require "i18n-airbrake/configuration"
require "i18n-airbrake/handler"

module I18n
  module Airbrake

    class << self
      # A Airbrake configuration object. Must act like a hash and return sensible
      # values for all I18::Airbrake configuration options. See I18::Airbrake::Configuration.
      attr_writer :configuration

      # Call this method to modify defaults in your initializers.
      #
      # @example
      #   Airbrake.configure do |config|
      #     config.fail_when = Proc.new { |handler| handler }
      #     config.notify_when  = false
      #   end
      def configure(silent = false)
        yield(configuration)
      end

      # The configuration object.
      # @see I18::Airbrake.configure
      def configuration
        @configuration ||= Configuration.new
      end
    end

    def self.call(*args)
      Handler.new(*args).call
    end


  end
end

I18n.exception_handler = I18n::Airbrake
