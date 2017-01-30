require "spec_helper"

RSpec.describe Ios::Toolchain do
  it "has a version number" do
    expect(Ios::Toolchain::VERSION).not_to be nil
  end
end
