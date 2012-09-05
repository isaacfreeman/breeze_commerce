module Breeze
  module Admin
    module Commerce
      class OrdersController < Breeze::Admin::Commerce::Controller
        def index
          @orders = store.orders.all.reverse
        end
        
        def show
          @order = store.orders.find(params[:id])
        end
        
        def new
          @order = store.orders.new
        end
        
        def create
          @order = store.orders.build params[:order]
          if @order.save
            redirect_to admin_store_orders_path
          else
            render :action => "new"
          end
        end

        def edit
          @order = store.orders.find params[:id]
          @billing_statuses = Breeze::Commerce::Store.first.order_statuses.where(:type => :billing)
          @shipping_statuses = Breeze::Commerce::Store.first.order_statuses.where(:type => :shipping)
        end

        def update
          @order = store.orders.find params[:id]
          if @order.update_attributes(params[:order])
            flash[:notice] = "The order was saved."
            redirect_to edit_admin_store_order_path(@order)
          else
            render :action => "edit"
          end
        end
        
       def destroy
        @order = store.orders.find(params[:id])
        @order.try :destroy
       end        
        
      end
    end
  end
end