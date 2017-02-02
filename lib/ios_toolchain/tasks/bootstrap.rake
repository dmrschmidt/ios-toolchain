require 'ios_toolchain/helpers'
require 'ios_toolchain/project_analyzer'
require 'ios_toolchain/config_bootstrapper'

include IosToolchain::Helpers

desc 'iOS Toolchain maintenance tasks'
namespace :toolchain do
  desc "Bootstraps iOS Toolchain configuration (project_path optional)"
  task :bootstrap, :project_path do |t, args|
    args.with_defaults(:project_path => Bundler.root)

    analyzer = IosToolchain::ProjectAnalyzer.new(args[:project_path])
    bootstrapper = IosToolchain::ConfigBootstrapper.new(analyzer)
    bootstrapper.bootstrap!

    puts "Created #{config.file_name}."
  end
end
