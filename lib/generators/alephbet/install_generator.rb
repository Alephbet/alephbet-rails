require "rails/generators/active_record"

module Alephbet
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration
      desc "Generates (but does not run) a migration for the Alephbet tables"

      source_paths << File.join(File.dirname(__FILE__), "templates")

      def install
        route "mount Alephbet::Engine => '/alephbet'"
        template "initializer.rb", "config/initializers/alephbet.rb"
      end

      def self.next_migration_number(dirname)
        ::ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def self.migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" if requires_migration_number?
      end

      def self.requires_migration_number?
        Rails::VERSION::MAJOR.to_i >= 5
      end

      def create_migration_file
        options = {
          :migration_version => migration_version
        }
        migration_template "migration.erb", "db/migrate/create_alephbet_tables.rb", options
      end

      def migration_version
        self.class.migration_version
      end
    end
  end
end
