class Invoice < ActiveRecord::Base
  belongs_to :project
  belongs_to :our_company
  has_many :invoice_items
  belongs_to :additional_law
  belongs_to :admin_user


  scope :for_year_and_partner_and_our_company, ->(year, partner, our_company) do 
    where('extract(year from service_delivered_at) = ?', year)
                      .joins('INNER JOIN projects ON projects.id=invoices.project_id')
                      .joins('INNER JOIN partners ON projects.partner_id = partners.id')
                      .where('partners.id = ? and our_company_id=?', partner.id, our_company.id)

  end

  accepts_nested_attributes_for :invoice_items, allow_destroy: true #, reject_if: :reject_experience_date

  attr_accessor :payment_difference

  STATUSES = %w(sent paid_part paid_all paid_more storno cancelled)

  def set_next_values
    self.created_at = Time.now
    self.price = 0
    invoice_number_parts = self.invoice_number.split('-')
    sequence_id = "%02d" % (invoice_number_parts.last.to_i + 1).to_s

    year = invoice_number_parts.first.to_i

    if year != Time.current.year && Date.today.yday() > 14 # first invoice in the year is done for previous year
      year = Time.current.year
      sequence_id = '01'
    end

    mid_part = ''
    
    if invoice_number_parts.count == 3
      mid_part = "-#{invoice_number_parts.second}"
    end

    self.invoice_number = "#{year}#{mid_part}-#{sequence_id}"
    self.sent_at = 5.days.ago
    self.service_delivered_at = 5.days.ago
  end

  def storno?
    storno
  end


  def send_email
    if project.partner.forward_invoice_to_email
      ApplicationMailer.invoice_email(self).deliver_now
    end
  end
end
