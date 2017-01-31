require 'fileutils'

desc 'iOS Toolchain maintenance tasks'
namespace :toolchain do
  desc "Bootstraps iOS Toolchain configuration"
  task :bootstrap do
    config_name = 'ios_toolchain.yml'
    sample_config = File.expand_path("../../config/#{config_name}", __FILE__)
    target_file = File.join(Dir.pwd, config_name)

    FileUtils.cp sample_config, target_file
    puts "Created #{target_file}."
  end
end
