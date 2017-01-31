include IosToolchain::Helpers

def build_specs_cmd(scheme, options={})
  puts "Running specs for #{scheme}..."
  specs_cmd = []
  specs_cmd << 'set -o pipefail &&'
  specs_cmd << "xcodebuild -workspace #{project_file_path}/project.xcworkspace"
  specs_cmd << "-scheme #{scheme} test CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator"
  specs_cmd << "-destination platform='iOS Simulator,OS=10.2,name=iPhone 5'" unless options[:skip_32bit]
  specs_cmd << "-destination platform='iOS Simulator,OS=10.2,name=iPhone 7'"
  specs_cmd << '| bundle exec xcpretty'
  specs_cmd = specs_cmd.join(" ")
end

def run_tests_or_bail(tests, args)
  args.with_defaults(:skip_32bit => false)

  Rake::Task['clean:build'].reenable
  Rake::Task['clean:simulator'].reenable
  tests.each do |target|
    if(!system(build_specs_cmd(target, skip_32bit: args[:skip_32bit])))
      bail("Specs failure - please fix the failing specs and try again.")
    end
  end
end

desc "Run all the tests: unit and UI, 32bit and 64bit"
task :specs => ['specs:unit', 'specs:ui']

namespace :specs do
  desc "Run 64bit unit tests only"
  task :slim do
    Rake::Task['specs:unit'].invoke(skip_32bit: true)
  end

  desc "Run the unit tests (optionally skip 32 bit devices)"
  task :unit, [:skip_32bit] => ['clean:build', 'clean:simulator'] do |task, args|
    run_tests_or_bail(test_targets, args)
  end

  desc "Run the UI tests (optionally skip 32 bit devices)"
  task :ui, [:skip_32bit] => ['clean:build', 'clean:simulator'] do |task, args|
    run_tests_or_bail(ui_test_targets, args)
  end
end
