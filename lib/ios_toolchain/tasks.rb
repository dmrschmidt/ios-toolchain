require 'rake'
require 'ios_toolchain/config_bootstrapper'
require 'ios_toolchain/project_analyzer'

module IosToolchain
  class Tasks
    include Rake::DSL if defined? Rake::DSL

    def install_tasks
      tasks_path = File.expand_path('../tasks/**/*.rake', __FILE__)
      Dir.glob(tasks_path).each { |file| load file }
    end
  end
end
IosToolchain::Tasks.new.install_tasks
