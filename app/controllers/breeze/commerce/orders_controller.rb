module Breeze
  module Commerce
    class OrdersController < ApplicationController
      include Breeze::Commerce::CurrentOrder

      # Displays the current cart
      def edit
        @order = current_order
      end

      def remove_item
        @order = current_order
        line_item = @order.line_items.find(params[:id])
        line_item.delete if line_item
      end

      def populate
        @order = current_order
        
        product_id = params[:product_id]
        new_line_item =  LineItem.new(:product_id => product_id, :quantity => params[:quantity] || 1)
        existing_line_item = @order.line_items.where(:product_id => product_id).first 
        if existing_line_item
          existing_line_item.quantity += new_line_item.quantity
        else
          @order.line_items << new_line_item
        end

        @order.save
        
        redirect_to cart_path
      end

      def checkout
        @order = current_order 
      end

      def update
        @order = current_order

        if @order.save
          redirect_to :action => "thankyou"
        else
          render :action => "checkout"
        end
      end 

      def thankyou 
        @order = current_order
      end

    end
  end
end

