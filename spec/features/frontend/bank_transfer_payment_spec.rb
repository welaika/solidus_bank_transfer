# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Checkout - Payment with bank transfer', type: :feature, js: true do
  let(:payment_method) do
    create(:bank_transfer_payment_method,
           name: 'Bonifico',
           preferred_bank_name: 'Banca del Monopoli')
  end

  let(:user) { create(:user_with_addresses) }
  let(:order) { create(:order_with_line_items) }

  before do
    payment_method
    order.associate_user!(user)

    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: order)
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: user)
    allow_any_instance_of(Spree::OrdersController).to receive_messages(try_spree_current_user: user)
    # rubocop:enable RSpec/AnyInstance

    visit spree.checkout_state_path(:payment)
  end

  it 'shows the bank transfer payment' do
    expect(page).to have_content('Bonifico')
    expect(page).to have_content('Banca del Monopoli')
  end
end
