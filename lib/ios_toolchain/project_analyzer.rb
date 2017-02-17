require 'xcodeproj'
require 'pathname'

module IosToolchain
  class ProjectAnalyzer
    attr_reader :project_root, :project_file_path

    def initialize(project_root)
      project_root_path = Pathname.new(project_root).realpath
      @project_root = project_root_path.to_s
      @absolute_project_path = find_project_path!
      @project_file_path = relative_from_root(@absolute_project_path)

      @project = Xcodeproj::Project.open(@absolute_project_path)
    end

    def default_scheme
      shared_schemes.find { |name| name == project_name }
    end

    def default_sdk
    end

    def crashlytics_framework_path
      path = glob_excluding_carthage('**/Crashlytics.framework').first || return
      relative_from_root(path)
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

    def relative_from_root(path)
      "./#{Pathname(path).relative_path_from(Pathname.new(project_root)).to_s}"
    end

    def shared_schemes
      Xcodeproj::Project.schemes(project_file_path)
    end

    def project_name
      project_file_path.split(File::SEPARATOR)[-1].split('.')[-2]
    end

    def find_project_path!
      glob_excluding_carthage('**/*.xcodeproj').first.tap do |project|
        return project unless project.nil?

        error_message  = "No .xcodeproj file was found in #{project_root} "
        error_message += 'Run `rake toolchain:bootstrap[/path/containing/project/]`'
        throw error_message
      end
    end

    def glob_excluding_carthage(pattern)
      Dir.glob(File.join(project_root, pattern)).reject do |name|
        name =~ /\/Carthage\//
      end
    end

    attr_reader :project
  end
end
