require 'rake'

module IosToolchain
  class Tasks
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      Dir.glob('ios_toolchain/tasks/**/*.rake').each { |file| load file }
    end
  end
end
IosToolchain::Tasks.new.install_tasks
