# frozen_string_literal: true

RSpec.describe Getv do
  it 'has a version number' do
    expect(Getv::VERSION).not_to be nil
  end
end

RSpec.describe Getv::Package do
  let(:expected_versions) do
    ['0.9.0', '1.0.0']
  end

  context '::docker' do
    it 'returns correct docker version' do
      @package = described_class.new 'mypackage', type: 'docker', owner: 'apache', reject: '-'
      # allow(@package).to receive(:versions_using_docker).and_return(['0.9.0', '1.0.0'])
      require 'docker_registry2'
      allow(DockerRegistry2).to receive(:connect).and_return(double(tags: { 'tags' => expected_versions }))
      @package.versions
      expect(@package.opts[:latest_version]).to eq expected_versions.last
      expect(@package.opts[:versions]).to eq expected_versions
    end
  end
end
