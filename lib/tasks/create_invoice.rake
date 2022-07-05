namespace :invoices do
  desc "Dumps the database to db/APP_NAME.dump"
  task :create => :environment do

    if Date.today.day == 13 or Date.today.day == 25
      admin_user = AdminUser.find(1)

      last_invoice = admin_user.invoices.order('service_delivered_at desc nulls last').first

      if last_invoice.created_at.day != Date.today.day
        amount = admin_user.beweekly_salary_amount

        invoice =last_invoice.dup
        invoice.set_next_values
        invoice.price = 0
        invoice.usd_price = amount
        invoice.save!
      end
    end
  end    
end