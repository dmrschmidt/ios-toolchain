include IosToolchain::Helpers

namespace :distribute do
  task :crashlytics, :ipa_path, :configuration do |t, args|

    args.with_defaults(ipa_path: 'archive')
    puts 'distributing to crashlytics...'

    build_cmd = []
    build_cmd << "#{crashlytics_framework_path}/submit #{ENV['FABRIC_API_KEY']} #{ENV['FABRIC_BUILD_SECRET']}"
    build_cmd << "-ipaPath #{args[:ipa_path]}/DongleData-#{args[:configuration]}.ipa"
    build_cmd << "-groupAliases #{args[:configuration]}"
    sh(build_cmd.join(' '))
  end
end

def crashlytics_framework_path
  File.expand_path('../../../Externals/Crashlytics.framework', __FILE__)
end
