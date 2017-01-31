namespace :dependencies do
  desc "Fetches all dependencies"
  task :fetch => [:'fetch:carthage'] do
     puts "\n\n"
     puts "👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍 "
     puts "🚢        Dependencies are all updated!      🚢 "
     puts "👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍 "
     puts "\n\n"
  end

  desc "Updates carthage dependencies"
  task :update => [:'update:carthage']

  namespace :update do
    desc "updates our Carthage dependencies to the latest version"
    task :carthage do
      carthage_cmd = []
      carthage_cmd << "carthage"
      carthage_cmd << "update"
      carthage_cmd << "--platform ios"
      carthage_cmd << "--no-use-binaries"
      carthage_cmd = carthage_cmd.join(" ")

      system(carthage_cmd)
    end
  end

  namespace :fetch do
    desc "Fetches our Carthage dependencies to the locked in versions"
    task :carthage do
      carthage_cmd = []
      carthage_cmd << "carthage"
      carthage_cmd << "bootstrap"
      carthage_cmd << "--platform ios"
      carthage_cmd << "--no-use-binaries"
      carthage_cmd = carthage_cmd.join(" ")

      system(carthage_cmd)
    end
  end
end
