require "i18n"
require "i18n-airbrake/version"
require "i18n-airbrake/handler"

module I18n
  module Airbrake

    def self.call(*args)
      Handler.new(*args).call
    end

  end
end

I18n.exception_handler = I18n::Airbrake
