module I18n
  module Airbrake
    class Handler

      def initialize(exception, locale, key, options)
        @exception, @locale, @key, @options = exception, locale, key, options
      end

      def call
        if notify?
          notify
        end
        if fail?
          fail exception
        end
        @key.to_s
      end

      def exception
        if @exception.respond_to?(:to_exception)
          @exception.to_exception
        else
          @exception
        end
      end

      def notify
        ::Airbrake.notify exception
      end

      private

      # return a boolean: should we ignore or raise
      # fail_when: Proc.new { %w( development test ).include?(Rails.env) } # This is default
      # fail_when: nil # => will not fail ever
      # memoized so only determined once per invocation of the handler
      def fail?
        @fail ||= begin
          if !I18n::Airbrake.configuration[:fail_when].respond_to?(:call)
            false
          else
            !! I18n::Airbrake.configuration[:fail_when].call(self)
          end
        end
      end

      # return a boolean: should we be quiet or notify
      # notify_when: nil # => By default when failing we do not notify, and when not failing we do notify
      # memoized so only determined once per invocation of the handler
      def notify?
        @notify ||= begin
          if !I18n::Airbrake.configuration[:notify_when].respond_to?(:call)
            !fail?
          else
            !! I18n::Airbrake.configuration[:notify_when].call(self)
          end
        end
      end

    end
  end
end
