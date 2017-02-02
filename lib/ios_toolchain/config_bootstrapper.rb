require 'yaml'

module IosToolchain
  class ConfigBootstrapper
    def initialize(project_analyzer)
      @analyzer = project_analyzer
    end

    def bootstrap
      File.open(config_file_path, 'w') do |file|
        file.write config.to_yaml
      end
    end

    private

    def config_file_name
      '.ios_toolchain.yml'
    end

    def config_file_path
      File.join(analyzer.project_root, config_file_name)
    end

    def config
      {
        'project-file-path': analyzer.project_path,
        'default-scheme': analyzer.default_scheme,
        'default-sdk': nil,
        'crashlytics-framework-path': analyzer.crashlytics_framework_path,
        'app-targets': analyzer.app_targets,
        'test-targets': analyzer.test_targets,
        'ui-test-targets': analyzer.ui_test_targets
      }
    end

    attr_reader :analyzer
  end
end
