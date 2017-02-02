require 'spec_helper'
require 'ios_toolchain/config_bootstrapper'

RSpec.describe IosToolchain::ConfigBootstrapper do
  let(:project_root) { Dir.mktmpdir }
  let(:project_analyzer) { double('ProjectAnalyzer') }
  subject { IosToolchain::ConfigBootstrapper.new(project_analyzer) }

  describe('#bootstrap!') do
    let(:config_file_path) { File.join(project_root, '.ios_toolchain.yml') }

    before(:each) do
      allow(project_analyzer).to receive(:project_root).and_return(project_root)
      allow(project_analyzer).to receive(:project_path).and_return('project_file_path')
      allow(project_analyzer).to receive(:default_scheme).and_return('DefaultScheme')
      allow(project_analyzer).to receive(:crashlytics_framework_path).and_return('crashlytics_framework_path')
      allow(project_analyzer).to receive(:app_targets).and_return(['Target1', 'Target2'])
      allow(project_analyzer).to receive(:test_targets).and_return(['Target1Tests', 'Target2Tests'])
      allow(project_analyzer).to receive(:ui_test_targets).and_return(['Target1UITests', 'Target2UITests'])

      subject.bootstrap!
    end

    it('writes a .ios_toolchain.yml file to project root') do
      expect(File.exists?(config_file_path)).to be(true)
    end

    describe('contents') do
      let(:yaml) { YAML.load_file(config_file_path) }

      it('writes correct project-file-path') do
        expect(yaml[:'project-file-path']).to eq('project_file_path')
      end

      it('writes correct default-scheme') do
        expect(yaml[:'default-scheme']).to eq('DefaultScheme')
      end

      it('writes default-sdk') do
        expect(yaml[:'default-sdk']).to be_nil
      end

      it('writes correct crashlytics-framework-path') do
        expect(yaml[:'crashlytics-framework-path']).to eq('crashlytics_framework_path')
      end

      it('writes correct app-targets') do
        expect(yaml[:'app-targets']).to eq(['Target1', 'Target2'])
      end

      it('writes correct test-targets') do
        expect(yaml[:'test-targets']).to eq(['Target1Tests', 'Target2Tests'])
      end

      it('writes correct ui-test-targets') do
        expect(yaml[:'ui-test-targets']).to eq(['Target1UITests', 'Target2UITests'])
      end
    end
  end
end
