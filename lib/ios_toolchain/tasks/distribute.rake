require 'ios_toolchain/helpers'

include IosToolchain::Helpers

if config.crashlytics_installed?
  namespace :distribute do
    desc 'Distribute pre-built IPA to Crashlytics'
    task :crashlytics, :ipa_path, :configuration do |t, args|
      args.with_defaults(ipa_path: 'archive')
      puts 'Distributing to crashlytics...'

      build_cmd = []
      build_cmd << "#{config.crashlytics_framework_path}/submit #{ENV['FABRIC_API_KEY']} #{ENV['FABRIC_BUILD_SECRET']}"
      build_cmd << "-ipaPath #{args[:ipa_path]}/#{config.default_scheme}-#{args[:configuration]}.ipa"
      build_cmd << "-groupAliases #{args[:configuration]}"
      sh(build_cmd.join(' '))
    end
  end
end
