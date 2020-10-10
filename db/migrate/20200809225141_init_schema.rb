class InitSchema < ActiveRecord::Migration[6.0]
  def up
    create_table "active_storage_attachments" do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
    create_table "active_storage_blobs" do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
    create_table "assignments" do |t|
      t.integer "assignment_type"
      t.bigint "course_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.bigint "rubric_id"
      t.string "name"
      t.text "description"
      t.string "expected_input_filenames", default: ""
      t.index ["course_id", "name"], name: "index_assignments_on_course_id_and_name", unique: true
      t.index ["course_id"], name: "index_assignments_on_course_id"
      t.index ["rubric_id"], name: "index_assignments_on_rubric_id"
    end
    create_table "courses" do |t|
      t.string "name"
      t.string "term"
      t.string "section"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["name", "term", "section"], name: "index_courses_on_name_and_term_and_section", unique: true
    end
    create_table "criterions" do |t|
      t.bigint "rubric_item_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "criterion_type"
      t.string "criterion"
      t.string "response"
      t.decimal "points", precision: 5, scale: 2, default: "0.0"
      t.index ["rubric_item_id"], name: "index_criterions_on_rubric_item_id"
    end
    create_table "grading_items" do |t|
      t.bigint "rubric_item_id"
      t.bigint "submission_id"
      t.integer "status"
      t.text "comments"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.decimal "points_received", precision: 8, scale: 2, default: "0.0"
      t.string "status_detail"
      t.text "output"
      t.integer "error_count", default: 0
      t.index ["rubric_item_id"], name: "index_grading_items_on_rubric_item_id"
      t.index ["submission_id"], name: "index_grading_items_on_submission_id"
    end
    create_table "rubric_items" do |t|
      t.bigint "rubric_id"
      t.integer "graded_by"
      t.integer "seq"
      t.text "description"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "primary_file"
      t.string "secondary_file"
      t.string "tertiary_file"
      t.string "type"
      t.index ["rubric_id"], name: "index_rubric_items_on_rubric_id"
    end
    create_table "rubrics" do |t|
      t.string "name"
      t.bigint "user_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.boolean "visibility"
      t.index ["user_id"], name: "index_rubrics_on_user_id"
    end
    create_table "sessions" do |t|
      t.string "session_id", null: false
      t.text "data"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
      t.index ["updated_at"], name: "index_sessions_on_updated_at"
    end
    create_table "students" do |t|
      t.string "first_name"
      t.string "last_name"
      t.bigint "course_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["course_id"], name: "index_students_on_course_id"
      t.index ["first_name", "last_name", "course_id"], name: "index_students_on_first_name_and_last_name_and_course_id", unique: true
    end
    create_table "submissions" do |t|
      t.bigint "student_id"
      t.bigint "assignment_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
      t.index ["student_id"], name: "index_submissions_on_student_id"
    end
    create_table "ts_files" do |t|
      t.bigint "assignment_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["assignment_id"], name: "index_ts_files_on_assignment_id"
    end
    create_table "user_course_maps" do |t|
      t.bigint "user_id"
      t.bigint "course_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["course_id"], name: "index_user_course_maps_on_course_id"
      t.index ["user_id"], name: "index_user_course_maps_on_user_id"
    end
    create_table "users" do |t|
      t.string "first_name"
      t.string "last_name"
      t.string "email"
      t.string "password_digest"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "uuid"
    end
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
