class SetupFeaturesAndRoles < ActiveRecord::Migration
  def self.up
    create_table "feature_testers" do |t|
      t.integer "feature_id"
      t.integer "tester_id"
      t.boolean "enabled"
    end

    create_table "features" do |t|
      t.string  "name"
      t.boolean "enabled"
      t.boolean "restricted"
    end

    create_table "features_roles" do |t|
      t.integer "feature_id"
      t.integer "role_id"
    end

    create_table "roles" do |t|
      t.string "name"
    end

    create_table "roles_testers" do |t|
      t.integer "role_id"
      t.integer "tester_id"
    end
  end

  def self.down
    drop_table "feature_testers"
    drop_table "features"
    drop_table "features_roles"
    drop_table "roles"
    drop_table "roles_testers"
  end
end
