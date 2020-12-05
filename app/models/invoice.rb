class Invoice < ActiveRecord::Base
  belongs_to :project
  belongs_to :our_company
  has_many :invoice_items
  has_many :payments
  belongs_to :additional_law

  accepts_nested_attributes_for :invoice_items, allow_destroy: true #, reject_if: :reject_experience_date

  scope :autocomplete_scope, ->(q, user = nil) { where("invoice_number LIKE ?", "%#{q}%").select("invoice_number as value, id as id") }

  attr_accessor :payment_difference

  STATUSES = %w(sent paid_part paid_all paid_more storno cancelled)

  def set_next_values
    self.created_at = Time.now
    self.price = 0
    invoice_number_parts = self.invoice_number.split('-')
    sequence_id = "%02d" % (invoice_number_parts.second.to_i + 1).to_s

    year = invoice_number_parts.first.to_i

    if year != Time.current.year && Date.today.yday() > 14 # first invoice in the year is done for previous year
      year = Time.current.year
      sequence_id = '01'
    end
    self.invoice_number = "#{year}-#{sequence_id}"
    self.sent_at = 5.days.ago
    self.service_delivered_at = 5.days.ago
  end

  def storno?
    storno
  end

  def paid_part!
    puts "part paid"
    self.status = "paid_part"
    save!
  end

  def paid_all!
    self.status = "paid_all"
    save!
  end

  def paid_more!
    self.status = "paid_more"
    save!
  end

  def payments_sum
    tmp_payments_sum = 0
    payments.each do |payment|
      tmp_payments_sum = tmp_payments_sum + payment.price
    end
    return tmp_payments_sum
  end

  def m3_table_admin_autocomplete_label
    invoice_number
  end

  def payment_difference
    "Ammount: #{price} #{currency} / Paid #{payments_sum} #{currency} "
  end

end
