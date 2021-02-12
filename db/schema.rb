# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_08_223902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "course_id"
    t.integer "identifier"
    t.string "name", null: false
    t.string "category", null: false
    t.text "description", default: "", null: false
    t.bigint "scale_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "name"], name: "index_assignments_on_course_id_and_name", unique: true
    t.index ["course_id"], name: "index_assignments_on_course_id"
    t.index ["identifier"], name: "index_assignments_on_identifier", unique: true
    t.index ["scale_id"], name: "index_assignments_on_scale_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "collaborator_ids", default: [], array: true
    t.string "name", null: false
    t.string "section", null: false
    t.integer "term", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name", "section", "term"], name: "index_courses_on_user_id_and_name_and_section_and_term", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "dependencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "version"
    t.string "source", null: false
    t.string "type", null: false
    t.string "executable", null: false
    t.string "checksum"
    t.boolean "public", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_dependencies_on_name", unique: true
  end

  create_table "grade_items", force: :cascade do |t|
    t.bigint "participant_id"
    t.bigint "rubric_item_id"
    t.string "status", null: false
    t.text "stdout", default: "", null: false
    t.text "stderr", default: "", null: false
    t.integer "exitstatus", default: 0, null: false
    t.decimal "point", precision: 5, scale: 2, default: "0.0", null: false
    t.text "feedback", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "error", default: [], array: true
    t.index ["participant_id", "rubric_item_id"], name: "index_grade_items_on_participant_id_and_rubric_item_id", unique: true
    t.index ["participant_id"], name: "index_grade_items_on_participant_id"
    t.index ["rubric_item_id"], name: "index_grade_items_on_rubric_item_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "assignment_id"
    t.bigint "student_id"
    t.integer "identifier", null: false
    t.string "full_name", null: false
    t.string "email_address", null: false
    t.boolean "status", null: false
    t.decimal "grade", precision: 5, scale: 2
    t.decimal "maximum_grade", precision: 5, scale: 2, null: false
    t.boolean "grade_can_be_changed", default: true, null: false
    t.datetime "last_modified_submission"
    t.datetime "last_modified_grade"
    t.text "feedback_comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id", "student_id"], name: "index_participants_on_assignment_id_and_student_id", unique: true
    t.index ["assignment_id"], name: "index_participants_on_assignment_id"
    t.index ["student_id"], name: "index_participants_on_student_id"
  end

  create_table "programs", force: :cascade do |t|
    t.bigint "assignment_id"
    t.bigint "parent_program_id"
    t.string "name", null: false
    t.string "extension", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_programs_on_assignment_id"
    t.index ["parent_program_id"], name: "index_programs_on_parent_program_id"
  end

  create_table "rubric_criteria", force: :cascade do |t|
    t.bigint "rubric_item_id"
    t.string "type", null: false
    t.string "action", null: false
    t.decimal "point", precision: 5, scale: 2, default: "0.0", null: false
    t.string "feedback", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rubric_item_id"], name: "index_rubric_criteria_on_rubric_item_id"
  end

  create_table "rubric_items", force: :cascade do |t|
    t.bigint "rubric_id"
    t.string "type", null: false
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rubric_id"], name: "index_rubric_items_on_rubric_id"
  end

  create_table "rubrics", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "assignment_id"
    t.boolean "published", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_rubrics_on_assignment_id"
    t.index ["user_id"], name: "index_rubrics_on_user_id"
  end

  create_table "scales", force: :cascade do |t|
    t.string "type", null: false
    t.jsonb "scale", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["participant_id"], name: "index_submissions_on_participant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "random_password", default: false, null: false
    t.string "role", default: "Student", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
