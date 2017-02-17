require 'yaml'
require 'ios_toolchain/config'

module IosToolchain
  class ConfigBootstrapper
    def initialize(project_analyzer)
      @analyzer = project_analyzer
    end

    def bootstrap!
      File.open(config_file_path, 'w') do |file|
        file.write config.to_yaml
      end
    end

    private

    def config_file_name
      Config.new.file_name
    end

    def config_file_path
      File.join(analyzer.project_root, config_file_name)
    end

    def config
      {
        'project-file-path' => analyzer.project_file_path,
        'default-scheme' => analyzer.default_scheme,
        'default-sdk' => 'iphoneos10.2',
        'default-32bit-test-device' => "'iOS Simulator,OS=10.2,name=iPhone 5'",
        'default-64bit-test-device' => "'iOS Simulator,OS=10.2,name=iPhone 7'",
        'app-targets' => analyzer.app_targets,
        'test-targets' => analyzer.test_targets,
        'ui-test-targets' => analyzer.ui_test_targets,
        'provisioning-path' => './provisioning',
        'crashlytics-framework-path' => analyzer.crashlytics_framework_path
      }
    end

    attr_reader :analyzer
  end
end
