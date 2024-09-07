class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :catch_invalid_foreign_key

  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      flash.notice = "The customer record was updated successfully."
      redirect_to @customer
    else
      render :edit, status: :unprocessable_entity
    end
  end

# Enable destory if they do not have orders

  # DELETE /customers/1 or /customers/1.json

  def destroy
    begin
      @customer.destroy
      flash[:success] = "The customer record was successfully deleted."
    rescue ActiveRecord::InvalidForeignKey
      flash[:error] = "The customer record could not be deleted because the customer has associated orders."
    rescue StandardError => e
      flash[:error] = "An error occurred while deleting the customer: #{e.message}"
    end

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone, :email)
    end

    # Useful to handle all/different errors: https://rollbar.com/blog/handle-exceptions-in-ruby-with-rescue/, https://patrickkarsh.medium.com/ruby-refinements-unlocking-the-power-of-guard-clauses-for-streamlined-programming-5b60b2f2e6e
    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      # add rescue ActiveRecord::InvalidForeignKey to catch all foriegn key errors
      flash.alert = e.to_s
      redirect_to customers_path
    end

    def catch_invalid_foreign_key(e)
      Rails.logger.debug("Invalid foreign key exception: #{e.message}")
      flash[:error] = "This record cannot be deleted because it has associated data."
      redirect_back(fallback_location: customers_path)
    end
end
