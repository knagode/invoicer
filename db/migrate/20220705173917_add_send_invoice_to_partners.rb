class AddSendInvoiceToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :forward_invoice_to_email, :string
  end
end
