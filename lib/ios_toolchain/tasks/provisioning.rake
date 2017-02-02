include IosToolchain::Helpers
require "fileutils"

desc 'helpers for dealing with provisiong'
namespace :provisioning do
	desc 'copies provisioning profiles from the repo to the appropriate system location'
	task :copy do
		local_profiles_path = File.join(config.provisioning_path, '*')
		system_profile_path = '~/Library/MobileDevice/Provisioning\ Profiles/'
		puts "copying provisioning profiles from '#{local_profiles_path}' to '#{system_profile_path}'"
		system("cp -r #{local_profiles_path} #{system_profile_path}")
	end
end
