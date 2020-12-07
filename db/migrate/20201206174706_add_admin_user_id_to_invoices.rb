class AddAdminUserIdToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :admin_user_id, :integer
    add_column :bank_transactions, :admin_user_id, :integer
  end
end
