FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_bank_transfer/factories'

  factory :bank_transfer_payment_method, class: Spree::PaymentMethod::BankTransfer do
    name 'Bank Transfer'
    preferred_bank_name 'Uncle Scrooge Bank & Partners'
    preferred_iban 'IT00 S000 0000 0000 0000 0123 456'
    preferred_holder 'Donald Duck'
    description 'Bank transfer'
  end
end
