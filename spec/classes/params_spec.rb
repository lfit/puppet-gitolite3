require 'spec_helper'
describe 'gitolite3', :type => 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os} with key_content and defaults for all parameters" do
      it { should compile }
      it { should contain_class('gitolite3::params') }
    end
  end
end
