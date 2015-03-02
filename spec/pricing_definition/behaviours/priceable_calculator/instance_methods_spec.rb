require 'spec_helper'
require 'support/active_record'
require 'support/helpers'

module PricingDefinition
  module Behaviours
    module PriceableCalculator
      describe InstanceMethods do
        let(:klass) { ::AcmeOrder }
        let(:priceable_calculator_options) { { priceable: :test_priceable, priceable_addons: [:test_addon], priceable_modifiers: [:test_modifier], volume: :quantity, interval_start: :request_date } }

        before(:each) do
          klass.priceable_calculator(priceable_calculator_options) do |config|
            config.add_party :acme_inc, currency: "USD", name: "ACME Inc.", base: true
            config.add_party :business, currency: :currency, name: :name
          end
        end

        describe '#calculator_config' do
          subject { klass.new.calculator_config }

          it 'returns class configuration for priceable_calculator behaviour' do
            expect(subject).to eq(klass.priceable_calculator_config)
          end
        end

        describe '#calculator' do
          subject { klass.new.calculator }

          it 'returns an instance of Helpers::Calculator' do
            expect(subject).to be_a(Helpers::Calculator)
          end
        end
      end
    end
  end
end