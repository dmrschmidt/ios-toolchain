include Helpers

def build_specs_cmd(scheme, skip_32bit=false)
  puts "Running specs for #{scheme}..."
  specs_cmd = []
  specs_cmd << 'set -o pipefail &&'
  specs_cmd << "xcodebuild -workspace DongleData.xcodeproj/project.xcworkspace"
  specs_cmd << "-scheme #{scheme} test CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator"
  specs_cmd << "-destination platform='iOS Simulator,OS=9.3,name=iPhone 5'" unless skip_32bit
  specs_cmd << "-destination platform='iOS Simulator,OS=9.3,name=iPhone 6'"
  specs_cmd << '| bundle exec xcpretty'
  specs_cmd = specs_cmd.join(" ")
end


desc "Run all the tests"
task :specs => ['specs:dongledata_unit', 'specs:dongleconnectivity', 'specs:dongledata_ui']

namespace :specs do
  desc "Run most important tests"
  task :slim do
    Rake::Task['specs:dongledata_unit'].invoke(true)
    Rake::Task['specs:dongleconnectivity'].invoke(true)
  end

  desc "Run the unit tests for the DongleData application"
  task :dongledata_unit, [:skip_32bit] => ['clean:build', 'clean:simulator'] do |task, args|
    Rake::Task['clean:build'].reenable
    Rake::Task['clean:simulator'].reenable
    if(!system(build_specs_cmd("DongleDataTests", args[:skip_32bit])))
      bail("Unit spec failure - please fix the failing specs and try again")
    end
  end

  desc "Run the UI tests for the DongleData application"
  task :dongledata_ui => ['clean:build', 'clean:simulator'] do
    Rake::Task['clean:build'].reenable
    Rake::Task['clean:simulator'].reenable
    if(!system(build_specs_cmd("DongleDataUITests")))
      bail("UI spec failure - please fix the failing specs and try again")
    end
  end

  desc 'Run the DongleConnectivity framework tests'
  task :dongleconnectivity, [:skip_32bit] => ['clean:build', 'clean:simulator'] do |task, args|
    Rake::Task['clean:build'].reenable
    Rake::Task['clean:simulator'].reenable
    if(!system(build_specs_cmd("DongleConnectivityTests", args[:skip_32bit])))
      bail("DongleConnectivity spec failure - please fix the failing specs and try again")
    end
  end
end
