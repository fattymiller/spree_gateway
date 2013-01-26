module SpreeGateway
  class Engine < Rails::Engine
    engine_name 'spree_gateway'

    config.autoload_paths += %W(#{config.root}/lib)
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    
    config.to_prepare &method(:activate).to_proc

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.gateway.payment_methods", :after => "spree.register.payment_methods" do |app|
        app.config.spree.payment_methods << Spree::Gateway::AuthorizeNetCim
        app.config.spree.payment_methods << Spree::Gateway::AuthorizeNet
        app.config.spree.payment_methods << Spree::Gateway::Eway
        app.config.spree.payment_methods << Spree::Gateway::EwayRapid
        app.config.spree.payment_methods << Spree::Gateway::Linkpoint
        app.config.spree.payment_methods << Spree::Gateway::Moneris
        app.config.spree.payment_methods << Spree::Gateway::PayPal
        app.config.spree.payment_methods << Spree::Gateway::SagePay
        app.config.spree.payment_methods << Spree::Gateway::Beanstream
        app.config.spree.payment_methods << Spree::Gateway::BraintreeGateway
        app.config.spree.payment_methods << Spree::Gateway::Stripe
        app.config.spree.payment_methods << Spree::Gateway::Samurai
        app.config.spree.payment_methods << Spree::Gateway::Worldpay
        app.config.spree.payment_methods << Spree::Gateway::Banwire
    end
  end

end
