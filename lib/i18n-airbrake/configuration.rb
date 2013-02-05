module I18n
  module Airbrake
    # Used to set up and modify settings for the notifier.
    class Configuration

      OPTIONS = [:fail_when, :notify_when].freeze

      # Specify when to fail.
      # The :fail_when proc will be called with the instance of the I18n::Airbrake::Handler as a parameter
      attr_accessor :fail_when

      # Specify when to notify:
      # Default is nil, which will notify when *not* failing (see :fail_when)
      attr_accessor :notify_when

      DEFAULT_FAIL_WHEN = Proc.new { |handler| %w( development test ).include?(Rails.env) }.freeze
      DEFAULT_NOTIFY_WHEN = nil.freeze

      def initialize
        @fail_when          = DEFAULT_FAIL_WHEN.dup
        @notify_when        = DEFAULT_NOTIFY_WHEN
      end

      # Allows config options to be read like a hash
      #
      # @param [Symbol] option Key for a given attribute
      def [](option)
        send(option)
      end

      # Returns a hash of all configurable options
      def to_hash
        OPTIONS.inject({}) do |hash, option|
          hash[option.to_sym] = self.send(option)
          hash
        end
      end

      # Returns a hash of all configurable options merged with +hash+
      #
      # @param [Hash] hash A set of configuration options that will take precedence over the defaults
      def merge(hash)
        to_hash.merge(hash)
      end

    end
  end
end
