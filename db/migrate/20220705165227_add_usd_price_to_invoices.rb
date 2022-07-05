class AddUsdPriceToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :usd_price, :decimal, precision: 10, scale: 2, null: true
  end
end
