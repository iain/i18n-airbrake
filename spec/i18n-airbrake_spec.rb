require 'i18n-airbrake'
require 'airbrake'

describe I18n::Airbrake do

  let(:translation) { "This is a known value" }

  module Rails
  end

  before do
    I18n.backend.store_translations :en, :known => translation
    Rails.stub(:env) { env }
    ::Airbrake.configure do |config|
      config.async = false
    end
  end

  context "when the translation can be found" do

    it "translates normally" do
      I18n.t(:known).should == translation
    end

    it "uses the default normally" do
      I18n.t(:unknown, :default => "With Default").should == "With Default"
    end

  end

  context "when the translation cannot be found" do
    context "development environment" do
      let(:env) { 'development' }

      it "does not notify airbrake" do
        ::Airbrake.should_not_receive(:notify)
        expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
      end

      it "raises the error" do
        expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
        ::Airbrake.should_not_receive(:notify)
      end
    end
    context "test environment" do
      let(:env) { 'test' }

      it "does not notify airbrake" do
        ::Airbrake.should_not_receive(:notify)
        expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
      end

      it "raises the error" do
        expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
        ::Airbrake.should_not_receive(:notify)
      end
    end
    context "production environment" do
      let(:env) { 'production' }

      it "notifies airbrake" do
        ::Airbrake.should_receive(:notify).with(an_instance_of(I18n::MissingTranslationData))
        I18n.t(:unknown)
      end

      it "returns the key" do
        ::Airbrake.stub(:notify)
        I18n.t(:unknown).should == "unknown"
        ::Airbrake.unstub(:notify)
      end

      it "does not raise the error" do
        expect { I18n.t(:unknown) }.to_not raise_error I18n::MissingTranslationData
      end
    end
  end
end
