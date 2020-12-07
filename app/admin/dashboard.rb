ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      div do 
        link_to "Oddaja dohodnine HOWTO?", 'https://mladipodjetnik.si/novice-in-dogodki/novice/navodila-za-oddajo-davcnega-obracuna-za-normirance?fbclid=IwAR1zyYc5huzFMNIgyA9-kvOeDCgCxk8l1Vw6imRJ4Ex8JLqV9FZpo8Wm_XQ', target: '_blank'
      end

      span class: "blank_slate" do
        OurCompany.all.each do |company| 
          # project_id: company.projects.pluck(:id)
          invoices = company.invoices.where(admin_user_id: current_admin_user.id)

          if invoices.any? && !company.name.include?('CLOSED!')
            h1 company.name
            invoices.group('yyyy').select('extract(year from service_delivered_at) as yyyy, sum(price) as total_income').order('yyyy DESC').each do |year|
              h2 year.yyyy.to_i
              h3 "Total: #{year.total_income.to_f} EUR"

              query = invoices.where('extract(year from service_delivered_at) = ?', year.yyyy)
                      .joins('INNER JOIN projects ON projects.id=invoices.project_id')
                      .joins('INNER JOIN partners ON projects.partner_id = partners.id')
                      .group('partners.id, partners.name, extract(year from service_delivered_at)')
                      .select('partners.name as partner_name, partners.id as partner_id, extract(year from service_delivered_at) as yyyy, sum(price) as total_price')

              h4 "Reports by company:"

              query.each do |row|
                div link_to row.partner_name + "(#{row.total_price} EUR)", partner_yearly_report_admin_invoices_path(year: row.yyyy.to_i, partner_id: row.partner_id, our_company_id: company.id)
              end
            end
          end
        end

      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
