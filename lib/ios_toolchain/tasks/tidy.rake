include Helpers

desc "Reports and attempts to tidy up common cleanliness problems with the codebase"
task :tidy => ['tidy:project_file', 'tidy:specs', 'tidy:whitespace', 'tidy:lint']

namespace :tidy do
  desc "Unfocusses any focussed specs"
  task :specs do
    puts "Unfocussing specs..."

    find_focussed_files_cmd = []
    find_focussed_files_cmd << 'grep -l -r -e'
    find_focussed_files_cmd << '"fit(\\|fdescribe(\\|fcontext"'
    find_focussed_files_cmd << TEST_DIRS
    find_focussed_files_cmd << '2>/dev/null'
    find_focussed_files_cmd = find_focussed_files_cmd.join(' ')

    `#{find_focussed_files_cmd}`.chomp.split("\n").each do |file_with_focussed_specs|
      puts "#{file_with_focussed_specs}"
      unfocus_cmd = []
      unfocus_cmd << "sed -i ''"
      unfocus_cmd << "-e 's/fit(/it(/g'"
      unfocus_cmd << "-e 's/fdescribe(/describe(/g;'"
      unfocus_cmd << "-e 's/fcontext(/context(/g;'"
      unfocus_cmd << "\"#{file_with_focussed_specs}\""
      unfocus_cmd = unfocus_cmd.join(" ")
      system(unfocus_cmd)
    end

    puts "Done!"
  end

  desc "Sorts the project file"
  task :project_file do
    puts "Sorting the project file..."
    system("script/sort-Xcode-project-file #{File.expand_path('../../../DongleData.xcodeproj', __FILE__)}")
    puts "Done!"
  end

  desc "Remove trailing whitespace from swift files"
  task :whitespace do
    puts "Removing trailing whitespace..."
    system("find #{PRODUCTION_DIRS.join(" ")} #{TEST_DIRS.join(" ")} -name \"*.swift\" -exec sed -i '' -e's/[ ]*$//' \"{}\" \\;")
    puts "Done!"
  end

  desc "Runs swiftlint"
  task :lint do
    puts "Linting..."
    if !system("which swiftlint")
      bail("Swiftlint is not installed - please install via `brew install swiftlint`")
    end
    if !system("swiftlint lint --strict")
      bail("Code hygeine problems were detected via swiftlint")
    end
  end
end
