# frozen_string_literal: true

RSpec.describe Getv do
  it 'has a version number' do
    expect(Getv::VERSION).not_to be nil
  end
end

RSpec.describe Getv::Package, :vcr do
  context '::docker' do
    it 'returns correct docker version' do
      @package = described_class.new 'superset', type: 'docker', owner: 'apache', reject: '-'
      @package.versions
      expect(@package.opts[:latest_version]).to eq '1.3.2'
      expect(@package.opts[:versions]).to eq ['1.0.0', '1.0.1', '1.1.0', '1.2.0', '1.3.0', '1.3.1', '1.3.2']
    end
  end
end
