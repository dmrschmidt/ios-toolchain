require 'rake'

module Ios
  module Toolchain
    class Tasks
      include Rake::DSL if defined? Rake::DSL
      def install_tasks
        Dir.glob('ios/tasks/**/*.rake').each { |file| load file }
      end
    end
  end
end
Ios::Toolchain::Tasks.new.install_tasks
