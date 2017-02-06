require "spec_helper"
require 'ios_toolchain/project_analyzer'

RSpec.describe IosToolchain::ProjectAnalyzer do
  let(:project_file) { 'SpecFixtureProject.xcodeproj' }
  let(:project_a_path) { File.expand_path('../../../fixtures/project_a', __FILE__) }
  let(:project_b_path) { File.expand_path('../../../fixtures/project_b', __FILE__) }
  let(:project_root) { project_a_path }

  subject { IosToolchain::ProjectAnalyzer.new(project_root) }

  describe('#project_root') do
    context('with an absolute path') do
      it('simply returns the passed in path') do
        expect(subject.project_root).to eq(project_root)
      end
    end

    context('with a relative path') do
      let(:project_root) { './spec/fixtures/project_a' }

      it('returns the correct absolute in path') do
        expect(subject.project_root).to eq(project_a_path)
      end
    end
  end

  describe('#default_scheme') do
    it('returns the shared scheme named like the project file') do
      expect(subject.default_scheme).to eq('SpecFixtureProject')
    end
  end

  describe('#default_sdk') do
    # maybe this can use IPHONEOS_DEPLOYMENT_TARGET
    # which will also be needed for testrunner
  end

  describe('#crashlytics_framework_path') do
    context('when .framework can be found') do
      let(:project_root) { project_b_path }
      let(:crashlytics_path) { File.join(project_b_path, 'Crashlytics.framework') }

      it('returns the found path') do
        expect(subject.crashlytics_framework_path).to eq(crashlytics_path)
      end
    end

    context('when .framework can NOT be found') do
      it('returns nil') do
        expect(subject.crashlytics_framework_path).to be_nil
      end
    end
  end

  describe('#app_targets') do
    it('returns all (guessed) app targets') do
      expect(subject.app_targets).to eq([
        'SpecFixtureProject',
        'SpecFixtureProjectFramework'
      ])
    end
  end

  describe('#test_targets') do
    it('returns all (guessed) test targets') do
      expect(subject.test_targets).to eq([
        'SpecFixtureProjectTests',
        'SpecFixtureProjectFrameworkTests'
      ])
    end
  end

  describe('#ui_test_targets') do
    it('returns all (guessed) UI test targets') do
      expect(subject.ui_test_targets).to eq([
        'SpecFixtureProjectUITests'
      ])
    end
  end
end
