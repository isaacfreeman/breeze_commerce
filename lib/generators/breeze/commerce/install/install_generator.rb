# class InstallGenerator < Rails::Generators::NamedBase
#   source_root File.expand_path('../templates', __FILE__)
# end

require 'rails/generators'

module Breeze
	module Commerce
	  module Generators
	    class InstallGenerator < Rails::Generators::Base
	    	source_root File.expand_path('../templates', __FILE__)

	      def install_breeze_commerce
	      	store = Breeze::Commerce::Store.first || Breeze::Commerce::Store.create( home_page: Breeze::Content::Page.first, allow_returning_customer_login: true )

	      # Setting up order statuses is now done in the store model
	      	# # Generate built-in order statuses for billing
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Browsing").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Browsing", :sort_order => 0,:description => "Customer has added items to his or her cart, but hasn't gone to checkout yet", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Started Checkout").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Started Checkout", :sort_order => 1, :description => "Customer has taken this order to checkout", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Payment in process").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Payment in process", :sort_order => 2, :description => "Customer has clicked Pay Now, and the order is currently with the payment processor", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Payment Received").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Payment Received", :sort_order => 3, :description => "Order has been paid in full", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Partial Payment Received").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Partial Payment Received", :sort_order => 4, :description => "Some payment has been received, but not full", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Cancelled by Customer").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Cancelled by Customer", :sort_order => 5, :description => "Customer cancelled order", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Cancelled by Merchant").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Cancelled by Merchant", :sort_order => 6, :description => "Merchant cancelled order", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :billing, :name => "Disputed").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :billing, :name => "Disputed", :sort_order => 7, :description => "Something's gone wrong", :store => store)
	       #  end

	      	# # Generate built-in order statuses for billing
	       #  if Breeze::Commerce::OrderStatus.where(:type => :shipping, :name => "Not Shipped Yet").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :shipping, :name => "Not Shipped Yet", :sort_order => 0, :description => "Newly-created order", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :shipping, :name => "Processing").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :shipping, :name => "Processing", :sort_order => 1, :description => "Getting ready to ship", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :shipping, :name => "Shipped").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :shipping, :name => "Shipped", :sort_order => 2, :description => "Order has been shipped", :store => store)
	       #  end
	       #  if Breeze::Commerce::OrderStatus.where(:type => :shipping, :name => "Will Not Ship").count == 0
	       #  	Breeze::Commerce::OrderStatus.create(:type => :shipping, :name => "Will Not Ship", :sort_order => 3, :description => "Shipping has been cancelled", :store => store)
	       #  end

	        # Generate an initial shipping method
	        if Breeze::Commerce::ShippingMethod.count == 0
	        	Breeze::Commerce::ShippingMethod.create(:price => 10, :name => "Standard Shipping")
	        end

	        # TODO: Put a list of things to do on the dashboard: check shipping methods, create a product, etc.

	      end
	    end
	  end
	end
end
