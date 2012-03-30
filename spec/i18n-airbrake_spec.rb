require 'i18n-airbrake'
require 'airbrake'

describe I18n::Airbrake do

  let(:env) { stub "env", :development? => false, :test? => false }
  let(:translation) { "This is a known value" }

  module Rails
  end

  before do
    I18n.backend.store_translations :en, :known => translation
    Rails.stub(:env) { env }
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

    it "notifies airbrake in production environment" do
      ::Airbrake.should_receive(:notify).with(an_instance_of(I18n::MissingTranslationData))
      I18n.t(:unknown)
    end

    it "titleizes the key in production environment" do
      ::Airbrake.stub(:notify)
      I18n.t(:unknown).should == "Unknown"
    end

    it "raises the error in development environment" do
      Rails.env.stub(:development?) { true }
      ::Airbrake.should_not_receive(:notify)
      expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
    end

    it "raises the error in test environment" do
      Rails.env.stub(:test?) { true }
      ::Airbrake.should_not_receive(:notify)
      expect { I18n.t(:unknown) }.to raise_error I18n::MissingTranslationData
    end

  end

end
