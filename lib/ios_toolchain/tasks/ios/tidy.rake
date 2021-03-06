require 'ios_toolchain/helpers'

include IosToolchain::Helpers

namespace :ios do
  desc 'Reports and attempts to tidy up common cleanliness problems with the codebase'
  task :tidy => ['ios:tidy:project_file', 'ios:tidy:specs', 'ios:tidy:whitespace', 'ios:tidy:lint']

  namespace :tidy do
    desc 'Unfocusses any focussed Quick specs'
    task :specs do
      puts 'Unfocussing specs...'

      find_focussed_files_cmd = []
      find_focussed_files_cmd << 'grep -l -r -e'
      find_focussed_files_cmd << '"fit(\\|fdescribe(\\|fcontext"'
      find_focussed_files_cmd << config.test_targets
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
        unfocus_cmd = unfocus_cmd.join(' ')
        system(unfocus_cmd)
      end

      puts 'Done!'
    end

    desc 'Sorts the project file'
    task :project_file do
      puts 'Sorting the project file...'
      system("script/sort-Xcode-project-file #{config.project_file_path}")
      puts 'Done!'
    end

    desc 'Removes trailing whitespace from code files'
    task :whitespace do
      file_extensions = %w{ h m swift }
      search_pattern = file_extensions.map { |ext| "-name \"*.#{ext}\""}.join(' -o ')
      puts 'Removing trailing whitespace...'
      system("find #{config.app_targets.join(' ')} #{config.test_targets.join(" ")} #{search_pattern} -exec sed -i '' -e's/[ ]*$//' \"{}\" \\;")
      puts 'Done!'
    end

    desc 'Runs swiftlint'
    task :lint do
      puts 'Linting...'
      unless system('which swiftlint')
        bail('Swiftlint is not installed - please install via `brew install swiftlint`')
      end
      unless system('swiftlint lint --strict')
        bail('Code hygeine problems were detected via swiftlint')
      end
      puts 'Done!'
    end
  end
end
