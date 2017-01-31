include IosToolchain::Helpers

desc 'builds the app'
namespace :build do
  task :with_config, :output_path, :configuration do |t, args|
    args.with_defaults(:output_path => 'archive')

    puts '===================================='
    puts "=== Archive Output Path building #{args[:configuration]}: in #{args[:output_path]}"
    puts '===================================='
    build_cmd = []
    build_cmd << 'xcodebuild -project DongleData.xcodeproj -scheme DongleData SYMROOT=build OBJROOT=build archive'
    build_cmd << 'CODE_SIGNING_REQUIRED=YES -sdk iphoneos9.3'
    build_cmd << "-configuration #{args[:configuration]} -archivePath #{args[:output_path]}/DongleData.xcarchive -derivedDataPath derived"
    sh(build_cmd.join(' '))
  end

  task :acceptance, :output_path do |t, args|
    args.with_defaults(:output_path => 'archive')
    Rake::Task['build:with_config'].invoke(args[:output_path], 'Acceptance')
  end

  task :beta, :output_path do |t, args|
    args.with_defaults(:output_path => 'archive')
    Rake::Task['build:with_config'].invoke(args[:output_path], 'Beta')
  end

  task :zip_archive, [:input_path, :output_path] do |t, args|
    args.with_defaults(:input_path => 'archive', :output_path => 'archive')

    sh("tar -cvz #{args[:input_path]}/DongleData.xcarchive > #{args[:output_path]}/DongleData.xcarchive.tar.gz")
  end
end
