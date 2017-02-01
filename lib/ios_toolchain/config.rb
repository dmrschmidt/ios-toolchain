require 'yaml'
require 'bundler'

module IosToolchain
  class Config
    def project_file_path
      File.join(Bundler.root, config['project-file-path'])
    end

    def default_sdk
      config['default-sdk']
    end

    def default_scheme
      config['default-scheme']
    end

    def app_targets
      config['app-targets']
    end

    def test_targets
      config['test-targets'] || []
    end

    def ui_test_targets
      config['ui-test-targets'] || []
    end

    def crashlytics_framework_path
      config['crashlytics-framework-path']
    end

    def crashlytics_installed?
      !crashlytics_framework_path.nil?
    end

    def file_name
      '.ios_toolchain.yml'
    end

  private

    def config
      YAML.load_file(File.join(Bundler.root, file_name))
    rescue
      puts 'WARNING: no ios_toolchain.yml config file found.'
      puts 'Run `rake toolchain:bootstrap`.'
      {}
    end
  end
end
