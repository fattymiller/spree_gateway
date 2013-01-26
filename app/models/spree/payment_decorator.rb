Spree::Payment.class_eval do
  alias_method :super_options, :gateway_options
  
  def gateway_options
    options = super_options
    options[:ip] = order.current_ip_address
    options
  end
end