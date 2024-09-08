require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:customer) { FactoryBot.create(:customer) }

  describe "GET /index" do
    it "renders the index template" do
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:order_params) { FactoryBot.attributes_for(:order, customer_id: customer.id) }

      it "creates a new Order" do
        expect {
          post orders_path, params: { order: order_params }
        }.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post orders_path, params: { order: order_params }
        expect(response).to redirect_to(order_path(Order.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new order" do
        expect {
          post orders_path, params: { order: { product_name: nil, product_count: nil, customer_id: nil } }
        }.to_not change(Order, :count)
      end

      it "renders the new template" do
        post orders_path, params: { order: { product_name: nil, product_count: nil, customer_id: nil } }
        expect(response).to render_template(:new)
      end
    end
  end
end
