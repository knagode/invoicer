# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_05_173917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "additional_laws", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "average_salaries", id: :serial, force: :cascade do |t|
    t.decimal "net", precision: 15, scale: 2, default: "0.0"
    t.decimal "gross", precision: 15, scale: 2, default: "0.0"
    t.string "country", limit: 255
    t.integer "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_transactions", id: :serial, force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id"
    t.boolean "is_processed"
    t.text "mail_body"
    t.string "mail_subject", limit: 255
    t.string "mail_from", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "invoice_id"
    t.integer "admin_user_id"
  end

  create_table "expense_categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "nice_id", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", id: :serial, force: :cascade do |t|
    t.integer "expense_category_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.string "currency", limit: 255, default: "EUR", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.datetime "spended_at"
    t.integer "payment_id"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attachment_file_name", limit: 255
    t.string "attachment_content_type", limit: 255
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "invoice_items", id: :serial, force: :cascade do |t|
    t.integer "invoice_id"
    t.string "description", limit: 255
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.string "currency", limit: 255, default: "EUR", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "discount", default: false, null: false
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "project_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.string "currency", limit: 255, default: "EUR", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "our_company_id"
    t.string "invoice_number", limit: 255
    t.datetime "sent_at"
    t.boolean "storno", default: false, null: false
    t.integer "due_days"
    t.string "status", limit: 255
    t.datetime "service_delivered_at"
    t.integer "additional_law_id"
    t.string "before_table_text", limit: 255
    t.integer "user_id"
    t.integer "admin_user_id"
    t.decimal "usd_price", precision: 10, scale: 2
  end

  create_table "minimum_salaries", id: :serial, force: :cascade do |t|
    t.decimal "net", precision: 15, scale: 2, default: "0.0"
    t.decimal "gross", precision: 15, scale: 2, default: "0.0"
    t.string "country", limit: 255
    t.integer "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauths", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider", limit: 255
    t.string "uid", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_oauths_on_provider_and_uid"
  end

  create_table "our_companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "reference_number", limit: 255
    t.string "address", limit: 255
    t.string "zip_code", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "trr", limit: 255
    t.string "bank", limit: 255
    t.string "swift_bic_code", limit: 255
    t.string "contact_name", limit: 255
    t.string "contact_phone", limit: 255
    t.string "contact_email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "registration_number", limit: 255
    t.string "vat_number", limit: 255
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "slug", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.datetime "published_at"
    t.string "status", limit: 255
    t.boolean "visible_in_menu"
  end

  create_table "partners", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "address", limit: 255
    t.string "zip_code", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "attention_to", limit: 255
    t.string "vat", limit: 255
    t.text "footer_text"
    t.string "vat_number", limit: 255
    t.string "forward_invoice_to_email"
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.integer "project_id"
    t.integer "our_company_id"
    t.integer "invoice_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.string "currency", limit: 255, default: "EUR", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "payed_at"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.text "content"
    t.string "url", limit: 255
    t.string "itunes_url", limit: 255
    t.string "google_url", limit: 255
    t.string "status", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "partner_id"
    t.index ["created_at"], name: "index_projects_on_created_at"
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "scrum_tasks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string "description", limit: 255
    t.time "time_to_do"
    t.time "time_used"
    t.string "not_finished_or_overtime_justification", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "scrum_id"
    t.integer "hours_planned", default: 0
    t.integer "minutes_planned", default: 0
    t.integer "hours_used", default: 0
    t.integer "minutes_used", default: 0
  end

  create_table "scrums", id: :serial, force: :cascade do |t|
    t.date "date"
    t.time "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "role", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "password_digest", limit: 255
    t.boolean "deleted", default: false, null: false
    t.boolean "enabled", default: true, null: false
  end

  create_table "vacations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "description", limit: 255
    t.date "end_date"
    t.float "days"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "start_date"
  end

  create_table "wanted_salaries", id: :serial, force: :cascade do |t|
    t.decimal "net", precision: 15, scale: 2, default: "0.0"
    t.date "valid_from"
    t.date "valid_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
