# iOS Toolchain

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ios_toolchain'
```

Next, you need to make the included rake tasks available to your environment. 

Add the following line to your `Rakefile`:

```ruby
require 'ios_toolchain/tasks'
```

Once this is done, verify that the tasks are now available by checking the output of `rake -T`.

Finally, most tasks require some configuration, e.g. to know where your Xcode project is located and what schemes and tasks exist. This configuration is read from a `.ios_toolchain.yml` file, which still needs to be created. Run

```shell
$ rake toolchain:bootstrap
```

You should now have an automatically configured `.ios_toolchain.yml`, which you can open in the editor of your choice if you need any further customization.

**Important Note:** For the above auto configuration, it is assumed that your `*.xcodeproj` file is in the root of your repository, which is also where the `.ios_toolchain.yml` *has* to be located. If your project structure differs, you can pass the path to your Xcode project file as an optional paramater to the above command.

## Usage

### Tasks
This is the full list of available tasks, as output by `rake -T`:

    rake git:check_for_uncommitted_changes            # Checks for uncommitted changes and aborts if any are found
    rake git:push_origin                              # Pushes the current branch to origin
    rake ios:build:acceptance                         # Builds the app with Acceptance configuration
    rake ios:build:beta                               # Builds the app with Beta configuration
    rake ios:build:default                            # Builds the app with Default configuration
    rake ios:build:with[output_path,configuration]    # Builds the app with specified Configuration to output path
    rake ios:carthage:fetch                           # Fetches our Carthage dependencies to the locked in versions
    rake ios:carthage:update                          # updates our Carthage dependencies to the latest version
    rake ios:clean                                    # Cleans the build & resets simulator
    rake ios:clean:build                              # Cleans the build
    rake ios:clean:simulator                          # Resets the simulator
    rake ios:export:archive[xcarchive_path,ipa_path]  # builds the app
    rake ios:provisioning:copy                        # copies provisioning profiles from the repo to the appropriate system location
    rake ios:specs                                    # Run all the tests: unit and UI, 32bit and 64bit
    rake ios:specs:slim                               # Run 64bit unit tests only
    rake ios:specs:ui[skip_32bit]                     # Run the UI tests (optionally skip 32 bit devices)
    rake ios:specs:unit[skip_32bit]                   # Run the unit tests (optionally skip 32 bit devices)
    rake ios:tidy                                     # Reports and attempts to tidy up common cleanliness problems with the codebase
    rake ios:tidy:lint                                # Runs swiftlint
    rake ios:tidy:project_file                        # Sorts the project file
    rake ios:tidy:specs                               # Unfocusses any focussed Quick specs
    rake ios:tidy:whitespace                          # Removes trailing whitespace from code files
    rake shipit                                       # Checks that we're ready to push, and then pushes the current branch to origin
    rake toolchain:bootstrap[project_path]            # Bootstraps iOS Toolchain configuration (project_path optional)
    rake validate                                     # Checks you if you need to do any cleanup of the code before you push

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dmrschmidt/ios_toolchain. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
