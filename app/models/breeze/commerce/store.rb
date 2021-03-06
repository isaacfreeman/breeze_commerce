# Stores settings for Breeze Commerce
module Breeze
  module Commerce
    class Store
      include Mongoid::Document

      attr_accessible :home_page_id, :terms_page_id, :allow_returning_customer_login, :currency, :default_shipping_method, :default_shipping_method_id

      belongs_to :home_page, :class_name => "Breeze::Content::Page"   # The root page for the store, which might be different from the root page for the site
      belongs_to :terms_page, :class_name => "Breeze::Content::Page"  # The page with terms and conditions which a customer must agree to before checking out
      belongs_to :default_shipping_method, :class_name => "Breeze::Commerce::ShippingMethod"
      field :allow_returning_customer_login, type: Boolean, default: true
      field :currency, default: 'NZD'

      # Set up built-in order statuses
      # In future we may provide the option to create custom order statuses for stores, but we need some standard built-in ones to work with.
      def set_up_order_statuses
          # Generate built-in order statuses for billing
          unless order_statuses.where(:type => :billing, :name => "Browsing").count > 0
            order_statuses.create(:type => :billing, :name => "Browsing", :sort_order => 0,:description => "Customer has added items to his or her cart, but hasn't gone to checkout yet")
          end
          unless order_statuses.where(:type => :billing, :name => "Started Checkout").count > 0
            order_statuses.create(:type => :billing, :name => "Started Checkout", :sort_order => 1, :description => "Customer has taken this order to checkout")
          end
          unless order_statuses.where(:type => :billing, :name => "Payment in process").count > 0
            order_statuses.create(:type => :billing, :name => "Payment in process", :sort_order => 2, :description => "Customer has clicked Pay Now, and the order is currently with the payment processor")
          end
          unless order_statuses.where(:type => :billing, :name => "Payment Received").count > 0
            order_statuses.create(:type => :billing, :name => "Payment Received", :sort_order => 3, :description => "Order has been paid in full")
          end
          unless order_statuses.where(:type => :billing, :name => "Partial Payment Received").count > 0
            order_statuses.create(:type => :billing, :name => "Partial Payment Received", :sort_order => 4, :description => "Some payment has been received, but not full")
          end
          unless order_statuses.where(:type => :billing, :name => "Cancelled by Customer").count > 0
            order_statuses.create(:type => :billing, :name => "Cancelled by Customer", :sort_order => 5, :description => "Customer cancelled order")
          end
          unless order_statuses.where(:type => :billing, :name => "Cancelled by Merchant").count > 0
            order_statuses.create(:type => :billing, :name => "Cancelled by Merchant", :sort_order => 6, :description => "Merchant cancelled order")
          end
          unless order_statuses.where(:type => :billing, :name => "Disputed").count > 0
            order_statuses.create(:type => :billing, :name => "Disputed", :sort_order => 7, :description => "Something's gone wrong")
          end

          # Generate built-in order statuses for billing
          unless order_statuses.where(:type => :shipping, :name => "Not Shipped Yet").count > 0
            order_statuses.create(:type => :shipping, :name => "Not Shipped Yet", :sort_order => 0, :description => "Newly-created order")
          end
          unless order_statuses.where(:type => :shipping, :name => "Processing").count > 0
            order_statuses.create(:type => :shipping, :name => "Processing", :sort_order => 1, :description => "Getting ready to ship")
          end
          unless order_statuses.where(:type => :shipping, :name => "Shipped").count > 0
            order_statuses.create(:type => :shipping, :name => "Shipped", :sort_order => 2, :description => "Order has been shipped")
          end
          unless order_statuses.where(:type => :shipping, :name => "Will Not Ship").count > 0
            order_statuses.create(:type => :shipping, :name => "Will Not Ship", :sort_order => 3, :description => "Shipping has been cancelled")
          end

      end
      
    end
  end
end
