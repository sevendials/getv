# frozen_string_literal: true

RSpec.describe Getv::Package, :vcr do
  context '::docker' do
    let :expected_versions do
      ['1.0.0', '1.0.1', '1.1.0', '1.2.0', '1.3.0', '1.3.1', '1.3.2']
    end
    before(:each) do
      @package = described_class.new 'superset', type: 'docker', owner: 'apache', reject: '-'
      @package.versions
    end

    after(:each) do
      @package.opts.delete :versions
      @package.opts.delete :latest_version
    end

    it 'returns correct docker versions' do
      expect(@package.opts[:versions]).to eq expected_versions
    end

    it 'returns latest version' do
      expect(@package.opts[:latest_version]).to eq expected_versions.last
    end
  end

  context '::gem' do
    let :expected_versions do
      ['7.12.0', '7.12.0', '7.12.1', '7.12.1', '7.12.1', '7.12.1', '7.13.1', '7.13.1', '7.13.1', '7.13.1']
    end
    before(:each) do
      @package = described_class.new 'puppet', type: 'gem', reject: '-'
      @package.versions
    end

    after(:each) do
      @package.opts.delete :versions
      @package.opts.delete :latest_version
    end

    it 'returns correct versions' do
      expect(@package.opts[:versions][-10..]).to eq expected_versions
    end

    it 'returns latest version' do
      expect(@package.opts[:latest_version]).to eq expected_versions.last
    end
  end
end
