require 'spec_helper'

describe 'nerve' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "nerve class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
	  :operatingsystemmajrelease => '6',
        }}
        it { should contain_class('nerve::params') }
        it { should contain_class('nerve::install') }
        it { should contain_class('nerve::config') }
        it { should contain_class('nerve::service') }
      end
    end
  end

  context 'when asked to install via gem' do
    let(:params) {{ :package_provider => 'gem', }}
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_package('nerve').with(
      :ensure   => '0.3.0',
      :provider => 'gem',
      :name     => 'nerve'
    ) }
  end

  context 'when given a specific package name and provider' do
    let(:params) {{ :package_ensure   => 'latest',
                    :package_provider => 'bla',
                    :package_name     => 'special-nerve'
    }}
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_package('nerve').with(
      :ensure   => 'latest',
      :provider => 'bla',
      :name     => 'special-nerve'
    ) }
  end

  context 'when not specified how to install' do
    let(:params) {{ }}
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_package('nerve').with(
      :ensure   => '0.3.0',
      :provider => nil,
      :name     => 'rubygem-nerve'
    ) }
  end
  
  # Config stuff
  context 'config by default' do
    let(:params) {{  }}
    let(:facts) {{ :osfamily => 'Debian',
                   :fqdn     => 'random_hostname'
    }}
    it { should contain_file('/etc/nerve/nerve.conf.json').with(
      :ensure   => 'present',
      :mode     => '0444'
    ) }
    it { should contain_file('/etc/nerve/nerve.conf.json').with_content(/"instance_id": "random_hostname"/) }
    it { should contain_file('/etc/nerve/nerve.conf.json').with_content(/"service_conf_dir": "\/etc\/nerve\/conf.d\/"/) }
    it { should contain_file('/etc/nerve/conf.d/').with(
      :ensure   => 'directory',
      :purge    => true
    ) }
  end

  context 'When alernate params are specified' do
    let(:params) {{ :config_file  => '/opt/bla.json',
                    :config_dir   => '/tmp/nerve.d/',
                    :purge_config => false
    }}
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_file('/opt/bla.json').with(
      :ensure   => 'present',
      :mode     => '0444'
    ) }
    it { should contain_file('/opt/bla.json').with_content(/"service_conf_dir": "\/tmp\/nerve.d\/"/) }
    it { should contain_file('/tmp/nerve.d/').with(
      :ensure   => 'directory',
      :purge    => false
    ) }
  end

  # Service Stuff
  context 'when requested not to run' do
    let(:params) {{ :service_ensure => 'stopped' }}
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_service('nerve').with(
      :ensure   => 'stopped'
    ) }
  end

end
