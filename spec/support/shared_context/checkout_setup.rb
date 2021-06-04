# frozen_string_literal: true

RSpec.shared_context 'with checkout setup' do
  let!(:store) { create(:store) }
  let!(:country) { create(:country, states_required: true) }
  let!(:state) { create(:state, country: country) }
  let!(:shipping_method) { create(:shipping_method) }
  let!(:stock_location) { create(:stock_location) }
  let!(:mug) { create(:product, name: 'RoR Mug') }
  let!(:payment_method) { create(:bank_transfer_payment_method) }
  let!(:zone) { create(:zone) }

  before { [store, country, state, shipping_method, stock_location, mug, payment_method, zone] }
end
