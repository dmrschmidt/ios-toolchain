require 'spec_helper'
require 'ios_toolchain/config'

RSpec.describe IosToolchain::Config do
  let(:project_a_path) { File.expand_path('../../../fixtures/project_a', __FILE__) }
  let(:project_b_path) { File.expand_path('../../../fixtures/project_b', __FILE__) }
  let(:project_root) { project_a_path }
  let(:config_file) { YAML.load_file(File.join(project_root, subject.file_name)) }

  subject { IosToolchain::Config.new() }

  before do
    allow(YAML).to receive(:load_file).and_return(config_file)
    allow(Bundler).to receive(:root).and_return(Pathname.new(project_root))
  end

  describe('#project_root_path') do
    it('returns the absolute (Bundler provided) root path') do
      expect(subject.project_root_path).to eq(project_a_path)
    end
  end

  describe('#project_file_path') do
    it('returns the absolute (Bundler provided) project file path') do
      expect(subject.project_file_path).to eq(File.join(project_root, 'QRCode.xcodeproj'))
    end
  end

  describe('#default_sdk') do
    it('returns the set default SDK') do
      expect(subject.default_sdk).to eq('iphoneos10.2')
    end
  end

  describe('#default_scheme') do
    it('returns the set default scheme') do
      expect(subject.default_scheme).to eq('QRCode')
    end
  end

  describe('#default_32bit_test_device') do
    it('returns the set 32bit testing device') do
      expect(subject.default_32bit_test_device).to eq("'iOS Simulator,OS=10.2,name=iPhone 5'")
    end
  end

  describe('#default_64bit_test_device') do
    it('returns the set 64bit testign device') do
      expect(subject.default_64bit_test_device).to eq("'iOS Simulator,OS=10.2,name=iPhone 7'")
    end
  end

  describe('#app_targets') do
    it('returns the set app targets') do
      expect(subject.app_targets).to eq(['QRCode', 'SomeOther'])
    end
  end

  describe('#test_targets') do
    it('returns the set test targets') do
      expect(subject.test_targets).to eq(['QRCodeTests', 'SomeOtherTests'])
    end
  end

  describe('#ui_test_targets') do
    it('returns the set UI test targets') do
      expect(subject.ui_test_targets).to eq([])
    end
  end

  describe('#provisioning_path') do
    context('when folder is set') do
      let(:project_root) { project_b_path }

      it('returns the absolute (Bundler provided) provisioning path') do
        expect(subject.provisioning_path).to eq(File.join(project_root, 'provisioning'))
      end
    end

    context('when folder is NOT set') do
      it('returns the absolute (Bundler provided) provisioning path') do
        expect(subject.provisioning_path).to be_nil
      end
    end
  end

  describe('#crashlytics_framework_path') do
    context('when framework exists') do
      let(:project_root) { project_b_path }

      it('returns the absolute (Bundler provided) crashlytics framework path') do
        expect(subject.crashlytics_framework_path).to eq(File.join(project_root, 'Frameworks/Crashlytics.framework'))
      end
    end

    context('when framework does not exist') do
      it('returns nil') do
        expect(subject.crashlytics_framework_path).to be_nil
      end
    end
  end

  describe('#crashlytics_installed?') do
    context('when framework exists') do
      let(:project_root) { project_b_path }

      it('returns true') do
        expect(subject.crashlytics_installed?).to be_truthy
      end
    end

    context('when framework does not exist') do
      it('returns false') do
        expect(subject.crashlytics_installed?).to be_falsy
      end
    end
  end

end
