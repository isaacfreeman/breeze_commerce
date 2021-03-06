module Breeze
  module Commerce
    class OrderStatus
      include Mongoid::Document

      STATUS_TYPES = [ :billing, :shipping ]

      attr_accessible :name, :description, :type, :sort_order
      field :name
      field :description
      field :type # :billing or :shipping
      field :sort_order, type: Integer

      scope :billing, where(type: :billing)
      scope :shipping, where(type: :shipping)

      has_many :orders, :class_name => "Breeze::Commerce::Order", :inverse_of => :order_statuses
      
      validates_presence_of :name, :type
      validates_inclusion_of :type, :in => STATUS_TYPES

      # Default billing status for new orders
      def self.billing_default
        Breeze::Commerce::OrderStatus.where(type: :billing, name: 'Browsing').first
      end

      # Default shipping status for new orders
      def self.shipping_default
        Breeze::Commerce::OrderStatus.where(type: :shipping, name: 'Not Shipped Yet').first
      end

    end
  end
end
