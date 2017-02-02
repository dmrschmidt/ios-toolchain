require 'yaml'
require 'bundler'

module IosToolchain
  class Config
    def project_file_path
      File.join(Bundler.root, config['project-file-path'])
    end

    def default_sdk
      config_yaml['default-sdk']
    end

    def default_scheme
      config_yaml['default-scheme']
    end

    def app_targets
      config_yaml['app-targets']
    end

    def test_targets
      config_yaml['test-targets'] || []
    end

    def ui_test_targets
      config_yaml['ui-test-targets'] || []
    end

    def crashlytics_framework_path
      config_yaml['crashlytics-framework-path']
    end

    def crashlytics_installed?
      !crashlytics_framework_path.nil?
    end

    def file_name
      '.ios_toolchain.yml'
    end

  private

    def config_yaml
      YAML.load_file(File.join(Bundler.root, file_name)) || {}
    rescue
      puts "\033[1;33m"
      puts "WARNING: no #{file_name} config file found."
      puts 'Run `rake toolchain:bootstrap`.'
      puts "\033[0m"
      {}
    end
  end
end
