class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    begin
      @customer.destroy
      flash.notice = "The customer record was successfully deleted."
    rescue ActiveRecord::InvalidForeignKey
      flash.notice = "That customer record could not be deleted, because the customer has orders."
    end
    redirect_to customers_url
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_name, :product_count, :customer_id)
  end
end
