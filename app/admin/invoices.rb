ActiveAdmin.register Invoice do
  # permit_params :processed, :notes

  permit_params :project_id, :price, :our_company_id, :invoice_number, :sent_at, :due_days, :service_delivered_at, :additional_law_id, :usd_price,
                invoice_items_attributes: [ :id, :invoice_id, :description, :_destroy ]


  scope('all', default: true) { |scope| scope.where(admin_user_id: current_admin_user.id) }

  member_action :pdf, method: :get do
    #render json: {su: 1}
    @object = resource

    render pdf: "#{@object.invoice_number}", template: 'invoices/show', layout: nil
  end

  member_action :send_pdf, method: :post do
    resource.send_email

    redirect_back(fallback_location: root_path, notice: "Email has just been sent")
  end

  collection_action :partner_yearly_report, method: :get do 
    @our_company = OurCompany.find(params[:our_company_id])
    @year = params[:year]
    @partner = Partner.find(params[:partner_id])

    @invoices = current_admin_user.invoices
                    .for_year_and_partner_and_our_company(@year, @partner, @our_company)
                    .order('service_delivered_at ASC')


    render pdf: "#{@year}_#{@partner.name.parameterize.underscore}_and_#{@our_company.name.parameterize.dasherize.underscore}", template: 'invoices/partner_report', layout: nil
  end

  #app/admin/your_resource.rb

  controller do
    def new
      @resource = current_admin_user.invoices
        .order('service_delivered_at DESC nulls last')
        .where('service_delivered_at IS NOT NULL')
        .first

      if @resource 
        #raise @resource.dup.attributes.except('id', 'created_at').to_json
        @resource = Invoice.new(@resource.dup.attributes.except('id', 'created_at'))
        @resource.set_next_values
        @resource.sent_at = Time.now
        @resource.service_delivered_at = Time.now
      else
        @resource = Invoice.new
      end
    end

    # def create
    #   super
    # end
  end

  before_create do |invoice|
    invoice.admin_user = current_admin_user
  end

  index do
    id_column
    column :invoice_number
    column :service_delivered_at
    column :price
    column :usd_price
    # column :user_id
    # column :product_id
    # column :stripe_charge_id do |order|
    #   link_to order.stripe_charge_id, (Rails.env.production? ? 'https://dashboard.stripe.com' : 'https://dashboard.stripe.com/test') + "/payments/#{order.stripe_charge_id}", target: '_blank' if order.stripe_charge_id
    # end
    # column :created_at
    # column :notes
    # column :processed


    actions defaults: true do |o|
      [
        link_to('PDF', pdf_admin_invoice_path(o)),
        link_to('Email PDF', send_pdf_admin_invoice_path(o), method: :post, data: {confirm: "Are you sure?"})
      ].join(' ').html_safe
    end
  end

    form do |f|
    # ...
    f.inputs do
      f.input :project
      f.input :price
      f.input :usd_price
      f.input :our_company
      f.input :invoice_number
      f.input :due_days
      f.input :sent_at, as: :date_picker
      f.input :service_delivered_at, as: :date_picker
      f.input :additional_law

      f.has_many :invoice_items, heading: true, allow_destroy: true do |ii|
        ii.input :description #, :as => :datetime_picker
      end
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
