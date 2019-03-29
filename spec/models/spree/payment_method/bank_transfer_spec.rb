# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::PaymentMethod::BankTransfer, type: :model do
  let(:order) { Spree::Order.new }
  let(:payment_method) { Spree::PaymentMethod::BankTransfer.create! name: "Bank Transfer", active: true }
  let(:payment) do
    Spree::Payment.new(amount: 0.0, order: order, payment_method: payment_method)
  end

  before do
    payment_method.save!
  end

  describe 'preferences' do
    before do
      payment_method.update_attributes!(
        preferred_bank_name: 'Uncle Scrooge Bank & Partners',
        preferred_iban: 'IT00 S000 0000 0000 0000 0123 456',
        preferred_holder: 'Donald Duck'
      )
    end

    it 'saves the preferences' do
      aggregate_failures do
        expect(payment_method.preferred_bank_name).to eq('Uncle Scrooge Bank & Partners')
        expect(payment_method.preferred_iban).to eq('IT00 S000 0000 0000 0000 0123 456')
        expect(payment_method.preferred_holder).to eq('Donald Duck')
      end
    end
  end

  describe '#actions' do
    it 'returns actions' do
      expect(payment_method.actions).to eq(%w[capture void credit])
    end
  end

  describe '#can_capture?' do
    context 'when payment state is checkout' do
      before do
        payment.update_attributes!(state: 'checkout')
      end

      it 'returns true' do
        expect(payment_method.can_capture?(payment)).to be true
      end
    end

    context 'when payment state is pending' do
      before do
        payment.update_attributes!(state: 'pending')
      end

      it 'returns true' do
        expect(payment_method.can_capture?(payment)).to be true
      end
    end

    context 'when payment state is not pending or checkout' do
      before do
        payment.update_attributes!(state: 'void')
      end

      it 'returns false' do
        expect(payment_method.can_capture?(payment)).to be false
      end
    end
  end

  describe '#can_void?' do
    context 'when payment state is not void' do
      before do
        payment.update_attributes!(state: 'pending')
      end

      it 'returns true' do
        expect(payment_method.can_void?(payment)).to be true
      end
    end

    context 'when payment state is void' do
      before do
        payment.update_attributes!(state: 'void')
      end

      it 'returns false' do
        expect(payment_method.can_void?(payment)).to be false
      end
    end
  end

  describe '#capture' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.capture
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.capture).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#void' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.void
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.void).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#try_void' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.try_void
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.try_void).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#credit' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.credit
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end
    it 'returns active merchant billing response' do
      expect(payment_method.credit).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#source_required?' do
    it 'returns false' do
      expect(payment_method.source_required?).to be false
    end
  end
end
