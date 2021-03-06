require 'ios_toolchain/helpers'

include IosToolchain::Helpers

namespace :ios do
  desc 'Builds the app'
  namespace :build do
    desc 'Builds the app with specified Configuration to output path'
    task :with, :output_path, :configuration do |t, args|
      args.with_defaults(:output_path => 'archive')

      puts '===================================='
      puts "=== Building #{args[:configuration]} archive in #{args[:output_path]}"
      puts '===================================='
      build_cmd = []
      build_cmd << "xcodebuild -project #{config.project_file_path}"
      build_cmd << "-scheme #{config.default_scheme} SYMROOT=build OBJROOT=build archive"
      build_cmd << "CODE_SIGNING_REQUIRED=YES -sdk #{config.default_sdk}"
      build_cmd << "-configuration #{args[:configuration]}" if args[:configuration]
      build_cmd << "-archivePath #{args[:output_path]}/#{config.default_scheme}.xcarchive"
      build_cmd << "-derivedDataPath derived"
      sh(build_cmd.join(' '))
    end

    desc 'Builds the app with Default configuration'
    task :default do
      Rake::Task['ios:build:with'].invoke('archive', nil)
    end

    desc 'Builds the app with Acceptance configuration'
    task :acceptance do
      Rake::Task['ios:build:with'].invoke('archive', 'Acceptance')
    end

    desc 'Builds the app with Beta configuration'
    task :beta do
      Rake::Task['ios:build:with'].invoke('archive', 'Beta')
    end
  end
end
