class MailWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # this method is called in most cases from Zapier.com (which receives forwarded email (gmail forward feature) and then triggers this webhooks)

    
    # body = ....

    # english email from transferwise:
    # Bla bla, Inc just sent you * 72,453.95 EUR * using
    # TransferWise.
    # Estimated arrival *by Wednesday, May 2* to account:
    # REFERENCE Payroll April 1 - 30 2018
    # BIC NTSBDEB1X**
    # IBAN **** **** **** **** 3333 17 ....

    # german email from transferwise
    # Hallo Klemen Nagode,\\r\\n\\r\\nBla bla, Inc hat dir 332.553,82 EUR mit TransferWise\\r\\ngesendet.
    #\\r\\n\\r\\nDas Geld sollte bis heute, am 2. Juli auf deinem Bankkonto sein. Hier ist\\r\\neine Zusammenfassung dieser 
    # Überweisung.\\r\\nÜberweisungsdetails Betrag: 2.553,82 EUR An dein Bankkonto endend auf:\\r\\n******************0017 Referenz: ...


    # Updated german email (new line just before enter...): 
#     body = """
# Wir haben deine Überweisung von Bla bla, Inc versendet.
# Das Geld sollte bis heute, am 2. Januar auf deinem Bankkonto sein. Hier ist
# eine Zusammenfassung dieser Überweisung.
# Überweisungsdetails Sender: Salals;s, Inc Betrag: 429.128,90
# EUR An dein Bankkonto endend auf: ******************0017 Referenz: Payroll
# December 16 - 31 2018 Du willst auch Geld überweisen?
#     """

    body = params[:body]

    body = ActionController::Base.helpers.strip_tags(body.split('<body>').last).squish # we are receiving HTML with tabs, multiple spaces

    user_id = params[:user_id] || 3

    bt = BankTransaction.create!(user_id: user_id, amount: params[:amount], mail_body: body, mail_from: params[:from], mail_subject: params[:subject]) 
    bt.try_to_create_invoice_from_body! if body

    if bt.is_processed
      render json: :ok
    else
      render json: :not_parsed, status: 500
    end
  end
end
