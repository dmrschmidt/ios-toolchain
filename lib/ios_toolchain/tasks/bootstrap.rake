require 'fileutils'
include IosToolchain::Helpers

desc 'iOS Toolchain maintenance tasks'
namespace :toolchain do
  desc "Bootstraps iOS Toolchain configuration"
  task :bootstrap do
    sample_config = File.expand_path("../../config/#{config.file_name}", __FILE__)
    target_file = File.join(Dir.pwd, config.file_name)

    FileUtils.cp sample_config, target_file
    puts "Created #{target_file}."
  end
end
