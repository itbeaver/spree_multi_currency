module Spree
  module CurrencyHelpers
    def self.included(receiver)
      receiver.send :helper_method, :supported_currencies
    end

    def supported_currencies
      Spree::Config[:supported_currencies].split(',').map { |code| ::Money::Currency.find(code.strip) }
    end

    def supported_regions
      Spree::Config[:supported_regions].split(',').map { |code| code.strip }
    end

    def region_to_currency(region)
      if region == 'USA'
        'USD'
      elsif region == 'UK'
        'GBP'
      elsif region == 'EU'
        'EUR'
      else
        'USD'
      end
    end
  end
end
