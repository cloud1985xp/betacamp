# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161025143420) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id",                null: false
    t.integer  "cart_id",                null: false
    t.integer  "quantity",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.string   "description"
    t.boolean  "enabled",        default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "parent_id"
    t.integer  "products_count", default: 0
    t.index ["enabled", "position"], name: "index_categories_on_enabled_and_position"
    t.index ["parent_id", "position", "enabled"], name: "index_categories_on_parent_id_and_position_and_enabled"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "subject",    null: false
    t.integer  "level",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_change_records", force: :cascade do |t|
    t.integer  "order_id"
    t.text     "values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_change_records_on_order_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",   null: false
    t.integer  "product_id", null: false
    t.integer  "quantity",   null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "amount",                     null: false
    t.string   "email",                      null: false
    t.string   "name"
    t.string   "mobile"
    t.boolean  "paid",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id",                       null: false
    t.string   "payment_method"
    t.integer  "amount"
    t.boolean  "paid",           default: false
    t.text     "params"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "description"
    t.text     "content"
    t.integer  "price"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "shelved_on"
    t.integer  "provider_id"
    t.index ["category_id", "active", "shelved_on"], name: "index_products_on_category_id_and_active_and_shelved_on"
    t.index ["category_id", "active"], name: "index_products_on_category_id_and_active"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["provider_id"], name: "index_products_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "contact"
    t.string   "telephone"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "street"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_grades", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.integer  "course_id",  null: false
    t.string   "grade"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "grade"], name: "index_student_grades_on_course_id_and_grade"
    t.index ["course_id"], name: "index_student_grades_on_course_id"
    t.index ["student_id", "grade"], name: "index_student_grades_on_student_id_and_grade"
    t.index ["student_id"], name: "index_student_grades_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age"], name: "index_students_on_age"
    t.index ["gender"], name: "index_students_on_gender"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
