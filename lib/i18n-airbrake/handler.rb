module I18n
  module Airbrake
    class Handler

      def initialize(exception, locale, key, options)
        @exception, @locale, @key, @options = exception, locale, key, options
      end

      def call
        if Rails.env.development? or Rails.env.test?
          fail exception
        else
          notify
          @key.to_s.titleize
        end
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
    end
  end
end
