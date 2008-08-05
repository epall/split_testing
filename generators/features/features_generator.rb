class FeaturesGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', "db/migrate", {:migration_file_name => "setup_features"}
    end
  end
end