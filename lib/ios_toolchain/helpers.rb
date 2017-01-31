require 'yaml'
require 'bundler'

module IosToolchain
  module Helpers
    LINE_LENGTH = 45

    def project_file_path
      File.join(Bundler.root, config['project-file-path'])
    end

    def default_sdk
      config['default-sdk']
    end

    def default_scheme
      config['default-scheme']
    end

    def app_targets
      config['app-targets']
    end

    def test_targets
      config['test-targets'] || []
    end

    def ui_test_targets
      config['ui-test-targets'] || []
    end

    def crashlytics_framework_path
      config['crashlytics-framework-path']
    end

    def crashlytics_installed?
      !crashlytics_framework_path.nil?
    end

    def config
      YAML.load_file(File.join(Bundler.root, config_name))
    rescue
      puts 'WARNING: no ios_toolchain.yml config file found.'
      puts 'Run `rake toolchain:bootstrap`.'
      {}
    end

    def config_name
      '.ios_toolchain.yml'
    end

    def bail(msg="Uh oh, looks like something isn't right")
       puts "\n\n"
       puts "👎   👎   👎   👎   👎   👎   👎   👎   👎   👎   👎   👎 "
       print_msg(msg)
       puts "👎   👎   👎   👎   👎   👎   👎   👎   👎   👎   👎   👎 "
       abort
    end

    def print_msg(msg)
      msg_words = msg.split(" ")
      msg_lines = []

      msg_line = "💩  "
      msg_words.each do |word|
        if msg_line.length + word.length + 2 <= LINE_LENGTH
          msg_line = "#{msg_line} #{word}"
        else
          msg_line = pad_poo(msg_line)
          msg_lines.push(msg_line)
          msg_line = "💩   #{word}"
        end
      end

      last_line = msg_lines.last
      msg_lines.push(pad_poo(msg_line)) unless msg_line =~ /💩$/

      msg_lines.each { |line| puts line }
    end

    def pad_poo(msg_line)
      padding = LINE_LENGTH - msg_line.length - 3
      padding = padding < 0 ? 0 : padding
      "#{msg_line}#{' ' * padding}  💩"
    end
  end
end
