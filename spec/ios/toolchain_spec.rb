require "spec_helper"

RSpec.describe IosToolchain do
  it "has a version number" do
    expect(IosToolchain::VERSION).not_to be nil
  end
end
