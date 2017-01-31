module IosToolchain
  module Helpers
    TEST_DIRS = ["DongleDataTests", "DongleDataUITests", "DongleConnectivityTests"]
    PRODUCTION_DIRS = ["DongleData", "DongleConnectivity"]
    LINE_LENGTH = 45

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
