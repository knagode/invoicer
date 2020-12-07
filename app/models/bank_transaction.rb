class BankTransaction < ActiveRecord::Base
  belongs_to :admin_user

  def try_to_create_invoice_from_body!
    amount = mail_body.gsub("\n", ' ').split(" EUR ").first.split(" ").last

    if amount[-3] == ',' # we have EU number format
      #puts 'eu format'
      amount = amount.gsub('.', '').gsub(',', '.').to_d
    elsif amount[-3] == '.' # we have US number format
      #puts 'US format'
      amount = amount.gsub(',', '').to_d
    else
      #puts amount[-3]
      amount = amount.to_i
    end

    if amount.to_i > 0
      last_invoice = admin_user.invoices.order('service_delivered_at desc nulls last').first

      if last_invoice
        invoice =last_invoice.dup
        invoice.set_next_values
        invoice.invoice_items.build(price: amount, description: "Programming")

        invoice.save!

        update_attributes(is_processed: true, amount: amount, invoice_id: invoice.id)
      else
        raise 'create one invoice first - after that we will be able to create new invoices automatically'
      end
    end
  end
end
