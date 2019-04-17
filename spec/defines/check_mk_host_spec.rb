require 'spec_helper'

describe 'check_mk::host' do
  let(:title) { 'host1' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          target: 'target',
        }
      end

      it {
        is_expected.to contain_check_mk__host('host1')
        is_expected.to contain_concat__fragment('check_mk-host1').with(
          'target'  => 'target',
          'content' => %r{^  'host1',\n$},
          'order'   => 11,
        )
      }
    end

    context "on #{os} with host_tags" do
      let(:facts) { os_facts }
      let(:params) do
        {
          target: 'target',
          host_tags: ['tag1', 'tag2'],
        }
      end

      it {
        is_expected.to contain_check_mk__host('host1')
        is_expected.to contain_concat__fragment('check_mk-host1').with(
          'target'  => 'target',
          'content' => %r{^  'host1|tag1|tag2',\n$},
          'order'   => 11,
        )
      }
    end
  end
end
