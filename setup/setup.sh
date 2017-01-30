# Setup script for our project machines

echo "Make brew up-to-date"
brew update
brew doctor
brew upgrade

echo "Install Swiftlint"
brew install swiftlint

echo "Install Carthage"
brew install carthage
