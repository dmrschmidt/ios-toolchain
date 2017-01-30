
desc "Tells you if you need to do any cleanup of the code before you push"
task :am_i_done_yet  do
   Rake::Task['git:check_for_uncommitted_changes'].invoke
   Rake::Task['clean:build'].invoke
   Rake::Task['tidy'].invoke
   Rake::Task['git:check_for_uncommitted_changes'].reenable
   Rake::Task['git:check_for_uncommitted_changes'].invoke
   Rake::Task['specs:slim'].invoke
   puts "\n\n"
   puts "👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍 "
   puts "🚢        Looks like you're good to ship!    🚢 "
   puts "👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍   👍 "
   puts "\n\n"
end
