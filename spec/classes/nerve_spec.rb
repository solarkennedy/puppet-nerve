require 'spec_helper'

describe 'nerve' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "nerve class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily
        }}
        it { should include_class('nerve::params') }
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
      :ensure   => 'present',
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
      :ensure   => 'present',
      :provider => nil,
      :name     => 'rubygem-nerve'
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

  context 'unsupported operating system' do
    describe 'nerve class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta'
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
