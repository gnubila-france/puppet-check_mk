require 'spec_helper'

describe 'check_mk::service' do
  on_supported_os.each do |os, os_facts|
    context "with required parameters set on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          checkmk_service: 'omd',
          httpd_service: 'httpd',
        }
      end

      it {
        is_expected.to compile

        is_expected.to contain_class('check_mk::service')
        is_expected.to contain_service('httpd').with(
          'ensure' => 'running',
          'enable' => 'true',
        )

        is_expected.to contain_service('xinetd').with(
          'ensure' => 'running',
          'enable' => 'true',
        )

        is_expected.to contain_service('omd').with(
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasrestart' => 'true',
        )
      }
    end
  end
end
