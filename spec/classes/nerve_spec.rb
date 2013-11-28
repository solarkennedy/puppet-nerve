require 'spec_helper'

describe 'nerve' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "nerve class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('nerve::params') }

        it { should contain_class('nerve::install') }
        it { should contain_class('nerve::config') }
        it { should contain_class('nerve::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'nerve class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
