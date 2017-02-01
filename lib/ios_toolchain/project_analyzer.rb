require 'xcodeproj'

module IosToolchain
  class ProjectAnalyzer
    attr_reader :project_path

    def initialize(project_path)
      @project_path = project_path
      @project = Xcodeproj::Project.open(project_path)
    end

    def default_scheme
      shared_schemes.find { |name| name == project_name }
    end

    def default_sdk
    end

    def crashlytics_framework_path
      Dir.glob("#{project_root}/**/Crashlytics.framework").first
    end

    def app_targets
      project.targets.map(&:name).find_all do |name|
        !name.include?('Tests')
      end
    end

    def test_targets
      project.targets.map(&:name).find_all do |name|
        name.include?('Tests') && !name.include?('UITests')
      end
    end

    def ui_test_targets
      project.targets.map(&:name).find_all do |name|
        name.include?('UITests')
      end
    end

    private

    def shared_schemes
      Xcodeproj::Project.schemes(project_path)
    end

    def project_name
      project_path.split(File::SEPARATOR)[-1].split('.')[-2]
    end

    def project_root
      File.dirname(project_path)
    end

    attr_reader :project
  end
end
