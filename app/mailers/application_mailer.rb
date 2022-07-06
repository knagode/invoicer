class ApplicationMailer < ActionMailer::Base
  default from: ENV["SMTP_USER_NAME"]
  layout 'mailer'

  def invoice_email(invoice)
    @object = invoice

    attachments["#{invoice.invoice_number}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(:pdf => "MindMap", :template => 'invoices/show.html.haml', :locals => {:object => invoice}))
    
    mail(:subject => "Invoice #{invoice.invoice_number}", :to => invoice.project.partner.forward_invoice_to_email)
  end
end
