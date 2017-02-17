
desc "Checks that we're ready to push, and then pushes the current branch to origin"
task :shipit => [:validate, "git:push_origin"]  do
  puts 'That ship has sailed! 😎'
end
