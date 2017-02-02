require 'xcodeproj'
require 'pathname'

module IosToolchain
  class ProjectAnalyzer
    attr_reader :project_root, :project_path

    def initialize(project_root)
      @project_root = Pathname.new(project_root).realpath.to_s
      @project_path = find_project_path!
      @project = Xcodeproj::Project.open(@project_path)
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

    def find_project_path!
      Dir.glob(File.join(project_root, '/*.xcodeproj')).first.tap do |project|
        return project unless project.nil?

        error_message  = "No .xcodeproj file was found in #{project_root} "
        error_message += "Run `rake toolchain:bootstrap[/path/containing/project/]`"
        throw error_message
      end
    end

    attr_reader :project
  end
end
