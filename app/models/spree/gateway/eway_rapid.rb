module Spree
  class Gateway::EwayRapid < Gateway
    preference :login, :string
    
    attr_accessible :preferred_login

    # Note: EWay supports purchase method only (no authorize method).
    # Ensure Spree::Config[:auto_capture] is set to true

    def provider_class
      ActiveMerchant::Billing::EwayRapidGateway
    end
    
    def purchase(money, creditcard, gateway_options)
      gateway_options[:ip] = current_user.current_sign_in_ip if current_user.respond_to?(:current_sign_in_ip)
      provider.purchase(money, creditcard, gateway_options)
    end

    def options_with_test_preference
      options_without_test_preference.merge(:test => self.preferred_test_mode)
    end

    alias_method_chain :options, :test_preference
  end
end
