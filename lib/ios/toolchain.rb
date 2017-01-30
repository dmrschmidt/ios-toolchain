require 'ios/toolchain/version'
require 'rake'

module Ios
  module Toolchain
    class Tasks
      include Rake::DSL if defined? Rake::DSL
      def install_tasks
         load 'ios/tasks/**/*.rake'
      end
    end
  end
end
Ios::Toolchain::Tasks.new.install_tasks
