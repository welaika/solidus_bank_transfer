Deface::Override.new(
  virtual_path: 'spree/order_mailer/confirm_email',
  name: 'add_bank_details_to_confirm_email',
  insert_bottom: "[data-hook='payment-method']",
  partial: 'spree/order_mailer/bank_transfer_details'
)
