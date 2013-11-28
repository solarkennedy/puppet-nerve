require 'spec_helper'
describe 'nerve::register', :type => :define do

  describe 'With an example service' do
    let (:params) {{ 
      :title => 'service1',
      :port  => '3000',
    }}
  end

  describe 'When not specifying a port' do
    let (:params) {{ }}
    it { expect { should }.to raise_error(NameError) }
  end 

end # end describe
