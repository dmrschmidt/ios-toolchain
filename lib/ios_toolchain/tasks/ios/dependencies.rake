namespace :ios do
  namespace :carthage do
    desc 'updates our Carthage dependencies to the latest version'
    task :update do
      carthage_cmd = []
      carthage_cmd << 'carthage'
      carthage_cmd << 'update'
      carthage_cmd << '--platform ios'
      carthage_cmd << '--no-use-binaries'
      carthage_cmd = carthage_cmd.join(' ')

      system(carthage_cmd)
    end

    desc 'Fetches our Carthage dependencies to the locked in versions'
    task :fetch do
      carthage_cmd = []
      carthage_cmd << 'carthage'
      carthage_cmd << 'bootstrap'
      carthage_cmd << '--platform ios'
      carthage_cmd << '--no-use-binaries'
      carthage_cmd = carthage_cmd.join(' ')

      system(carthage_cmd)
    end
  end
end
