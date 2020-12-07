ActiveAdmin.register OurCompany do
  controller do
    def permitted_params
      params.permit!
    end
  end

  # permit_params :processed, :notes

  # index do
  #   id_column
  #   column :user_id
  #   column :product_id
  #   column :stripe_charge_id do |order|
  #     link_to order.stripe_charge_id, (Rails.env.production? ? 'https://dashboard.stripe.com' : 'https://dashboard.stripe.com/test') + "/payments/#{order.stripe_charge_id}", target: '_blank' if order.stripe_charge_id
  #   end
  #   column :created_at
  #   column :notes
  #   column :processed
  #   actions
  # end

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
