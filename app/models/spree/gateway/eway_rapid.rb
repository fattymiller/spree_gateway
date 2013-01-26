require Rails.root.join("lib/active_merchant/billing/gateways/eway_rapid")

module Spree
  class Gateway::EwayRapid < Gateway
    preference :login, :string
    preference :password, :string
    
    attr_accessible :preferred_login, :preferred_password

    # Note: EWay supports purchase method only (no authorize method).
    # Ensure Spree::Config[:auto_capture] is set to true

    def provider_class
      ActiveMerchant::Billing::EwayRapidGateway
    end
    
    def purchase(money, creditcard, gateway_options)
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      puts gateway_options.inspect
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      
      provider.purchase(money, creditcard, gateway_options)
    end

    def options_with_test_preference
      options_without_test_preference.merge(:test => self.preferred_test_mode)
    end

    alias_method_chain :options, :test_preference
  end
end
