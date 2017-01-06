require 'spec_helper'
describe 'gitolite3', :type => 'class' do
  on_supported_os.each do |os, facts|
    context "on #{os} with key_content and defaults for all parameters" do
      it { should compile }
      it { should contain_class('gitolite3') }
      it { should contain_package('gitolite3') }
      it { should contain_file('/var/lib/gitolite3/admin.pub')
           .with_content(/ssh-rsa AAAAFOOBAR/)
      }
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/UMASK\s*=>\s*0077/)
           .with_content(/LOG_EXTRA\s*=>\s*1/)
           .with_content(/GIT_CONFIG_KEYS\s*=>\s*''/)
           .with_content(/ENABLE\s*=>\s*\[\s*'help',/s)
      }
      it { should contain_anchor('gitolite3::begin') }
      it { should contain_class('gitolite3::config') }
      it { should contain_class('gitolite3::install') }
      it { should contain_anchor('gitolite3::end') }
    end
    context "on #{os} with custom hiera parameters" do
      let (:facts) {{ :testname => 'test1' }}
      it { should compile }
      it { should contain_class('gitolite3') }
      it { should contain_package('gitolite') }
      it { should contain_file('/var/lib/gitolite3/admin.pub')
           .with_content(/ssh-rsa AAAABAZQUUX/)
      }
      it { should contain_exec('gitolite3-setup')
           .with_command('/sbin/test setup -foobar admin.pub')
      }
      # Test main config items
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/UMASK\s*=>\s*0022/)
           .with_content(/GIT_CONFIG_KEYS\s*=>\s*'\.\*'/)
           .with_content(/LOG_DEST\s*=>\s*'syslog,normal'/)
           .with_content(/SITE_INFO\s*=>\s*'see https:\/\/example\.com\/gitolite'/)
           .with_content(/HOSTNAME\s*=>\s*'testhost'/)
           .with_content(/LOCAL_CODE\s*=>\s*"\$ENV{GL_ADMIN_BASE}\/local",/)
      }
      # Test roles
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/ROLES\s*=>\s*{\s*OWNERS\s*=>\s*1,\s*READERS\s*=>\s*1,\s*WRITERS\s*=>\s*1/s)
      }
      # Test repo aliases
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/REPO_ALIASES\s*=>\s*{/)
           .with_content(/WARNING\s*=>\s*q\(repos have changed\)/)
           .with_content(/PREFIX_MAPS\s*=>\s*{\s*'var\/lib\/'\s*=>\s*'srv\/lib\/'/s)
           .with_content(/'baz\/quuz'\s*=>\s*'fue\/loco',/)
      }
      # Test triggers
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/INPUT\s*=>\s*\[\s*'test_input_1',\s*'test_input_2',\s*\],/s)
           .with_content(/ACCESS_1\s*=>\s*\[\s*'test_access_1_1',\s*'test_access_1_2',\s*\],/s)
           .with_content(/ACCESS_2\s*=>\s*\[\s*'test_access_2_1',\s*'test_access_2_2',\s*\],/s)
           .with_content(/PRE_GIT\s*=>\s*\[\s*'test_pre_git_1',\s*'test_pre_git_2',\s*\],/s)
           .with_content(/POST_GIT\s*=>\s*\[\s*'test_post_git_1',\s*'test_post_git_2',\s*\],/s)
           .with_content(/PRE_CREATE\s*=>\s*\[\s*'test_pre_create_1',\s*'test_pre_create_2',\s*\],/s)
           .with_content(/POST_CREATE\s*=>\s*\[\s*'test_post_create_1',\s*'test_post_create_2',\s*\],/s)
           .with_content(/POST_COMPILE\s*=>\s*\[\s*'test_post_compile_1',\s*'test_post_compile_2',\s*\],/s)
      }
      # Test enable
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/ENABLE\s*=>\s*\[\s*'git-config',\s*'ssh-authkeys',\s*\],/s)
      }
      # Test unsafe_patt
      it { should contain_file('/var/lib/gitolite3/.gitolite.rc')
           .with_content(/UNSAFE_PATT\s*=\s*qr\(\[`#\\;\\\$\\&\(\)|<>\]\)/)
      }
    end
  end
end
