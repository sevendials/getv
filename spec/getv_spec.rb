# frozen_string_literal: true

RSpec.describe Getv do
  it 'has a version number' do
    expect(Getv::VERSION).not_to be nil
  end
end

RSpec.describe Getv::Package do
  context '::docker' do
    it 'returns correct docker version' do
      @package = described_class.new 'mypackage', type: 'docker', owner: 'apache', reject: '-'
      allow(@package).to receive(:versions_using_docker).and_return(['0.9.0', '1.0.0'])
      @package.versions
      expect(@package.opts[:latest_version]).to eq '1.0.0'
      expect(@package.opts[:versions]).to eq ['0.9.0', '1.0.0']
    end
  end
end
