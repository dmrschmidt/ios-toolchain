require 'yaml'
require 'bundler'

module IosToolchain
  class Config
    def project_file_path
      config_yaml['project-file-path']
    end

    def default_sdk
      config_yaml['default-sdk']
    end

    def default_scheme
      config_yaml['default-scheme']
    end

    def default_32bit_test_device
      config_yaml['default-32bit-test-device']
    end

    def default_64bit_test_device
      config_yaml['default-64bit-test-device']
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

    def provisioning_path
      config_yaml['provisioning-path']
    end

    def crashlytics_framework_path
      config_yaml['crashlytics-framework-path']
    end

    def crashlytics_installed?
      File.exists?(config_file_path) && !crashlytics_framework_path.nil?
    end

    def file_name
      '.ios_toolchain.yml'
    end

  private

    def config_file_path
      File.join(Bundler.root, file_name)
    end

    def config_yaml
      YAML.load_file(config_file_path) || {}
    rescue
      puts "\033[1;33m"
      puts "WARNING: no #{file_name} config file found."
      puts 'Run `rake toolchain:bootstrap`.'
      puts "\033[0m"
      exit
      {}
    end
  end
end
