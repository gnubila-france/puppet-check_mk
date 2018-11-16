require 'spec_helper'

describe 'check_mk' do
  on_supported_os.each do |os, os_facts|
    context "with defaults for all parameters on #{os}" do
      let(:facts) { os_facts }

      it {
        is_expected.to compile

        is_expected.to contain_class('check_mk')

        is_expected.to contain_class('check_mk::install').with(
          'filestore' => nil,
          'package'   => 'omd-0.56',
          'site'      => 'monitoring',
          'workspace' => '/root/check_mk',
          'before'    => 'Class[Check_mk::Config]',
        )

        is_expected.to contain_class('check_mk::config').with(
          'host_groups' => nil,
          'site'        => 'monitoring',
          'before'      => 'Class[Check_mk::Service]',
        )

        is_expected.to contain_class('check_mk::service')
      }
    end
  end
end
