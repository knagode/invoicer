class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def invoice_email(invoice)
    mail(:subject => "Invoice #{invoice.invoice_number}", :to => invoice.project.partner.forward_invoice_to_email) do |format|
      format.pdf do
        @object = invoice
        attachments["#{invoice.invoice_number}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(:pdf => "MindMap", :template => 'invoices/show.html.haml', :locals => {:object => invoice}))
      end
    end
  end
end
