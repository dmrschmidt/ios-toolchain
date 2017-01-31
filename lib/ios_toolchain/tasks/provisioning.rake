include IosToolchain::Helpers
require "fileutils"

desc 'helpers for dealing with provisiong'
namespace :provisioning do
	local_profiles_path = File.expand_path('../../../provisioning/*', __FILE__)
	system_profile_path = '~/Library/MobileDevice/Provisioning\ Profiles/'

	desc 'copies current provisioning profiles from the repo to the appropriate system location'
	task :copy do
		puts "copying provisioning profiles from '#{local_profiles_path}' to '#{system_profile_path}'"
		system("cp -r #{local_profiles_path} #{system_profile_path}")
	end
end
