ActiveAdmin.register Invoice do
  # permit_params :processed, :notes

  permit_params :project_id, :price, :our_company_id, :invoice_number, :sent_at, :due_days, :service_delivered_at, :additional_law_id,
                invoice_items_attributes: [ :id, :invoice_id, :description, :_destroy ]


  member_action :pdf, method: :get do
    #render json: {su: 1}
    @object = resource
    render pdf: "#{@object.invoice_number}", template: 'invoices/show', layout: nil
  end

  index do
    id_column
    column :invoice_number
    column :service_delivered_at
    column :price
    # column :user_id
    # column :product_id
    # column :stripe_charge_id do |order|
    #   link_to order.stripe_charge_id, (Rails.env.production? ? 'https://dashboard.stripe.com' : 'https://dashboard.stripe.com/test') + "/payments/#{order.stripe_charge_id}", target: '_blank' if order.stripe_charge_id
    # end
    # column :created_at
    # column :notes
    # column :processed


    actions defaults: true do |o|
      item "PDF", pdf_admin_invoice_path(o) #'#pdf' #app_data_application_integration_path(ai) 
    end
  end

    form do |f|
    # ...
    f.inputs do
      f.input :project
      f.input :price
      f.input :our_company
      f.input :invoice_number
      f.input :due_days
      f.input :sent_at, as: :date_picker
      f.input :service_delivered_at, as: :date_picker
      f.input :additional_law

      # f.has_many :invoice_items, heading: true, allow_destroy: true do |ii|
      #   ii.input :description #, :as => :datetime_picker
      # end
    end

    f.actions
  end

  # filter :user_id
  # filter :product_id
  # filter :stripe_charge_id
  # filter :created_at
  # filter :processed

  # form do |f|
  #   f.inputs do
  #     f.input :processed
  #     f.input :notes
  #   end
  #   f.actions
  # end
end
