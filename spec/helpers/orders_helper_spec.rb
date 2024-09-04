require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OrdersHelper. For example:
#
# describe OrdersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe OrdersHelper, type: :helper do
  describe '#format_order_total' do
    it 'formats the order total with two decimal places' do
      expect(helper.format_order_total(10.5)).to eq('$10.50')
    end

    it 'handles zero correctly' do
      expect(helper.format_order_total(0)).to eq('$0.00')
    end

    it 'handles large numbers correctly' do
      expect(helper.format_order_total(1234567.89)).to eq('$1,234,567.89')
    end
  end

  describe '#order_status_badge' do
    it 'returns "badge-success" for completed orders' do
      expect(helper.order_status_badge('completed')).to eq('<span class="badge badge-success">Completed</span>')
    end

    it 'returns "badge-warning" for pending orders' do
      expect(helper.order_status_badge('pending')).to eq('<span class="badge badge-warning">Pending</span>')
    end

    it 'returns "badge-danger" for cancelled orders' do
      expect(helper.order_status_badge('cancelled')).to eq('<span class="badge badge-danger">Cancelled</span>')
    end

    it 'returns "badge-secondary" for unknown statuses' do
      expect(helper.order_status_badge('unknown')).to eq('<span class="badge badge-secondary">Unknown</span>')
    end
  end
end
