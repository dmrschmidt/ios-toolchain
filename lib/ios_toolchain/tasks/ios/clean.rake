include IosToolchain::Helpers

namespace :ios do
  desc 'Cleans the build & resets simulator'
  task :clean => [:'clean:build']

  desc 'Cleans the build'
  namespace :clean do
    task :build do
      puts 'Cleaning...'

      clean_cmd = []
      clean_cmd << 'xcodebuild clean'
      clean_cmd << 'rm -rf build'
      system(clean_cmd.join("\n"))

      puts 'Done!'
    end

    desc 'Resets the simulator'
    task :simulator do
      puts 'Resetting simulator...'

      system("osascript -e 'tell application \"iOS Simulator\" to quit'") &&
      system("osascript -e 'tell application \"Simulator\" to quit'") &&
      system('xcrun simctl erase all')

      puts 'Done!'
    end
  end
end
