require 'spec_helper'

# rubocop:disable Layout/FirstArrayElementIndentation
describe 'systemd_journal_remote::upload' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('systemd_journal_remote::upload') }

        it {
          is_expected.to contain_class('systemd_journal_remote::upload::config')
            .that_comes_before('Class[systemd_journal_remote::upload::service]')
        }

        it { is_expected.to create_service('systemd-journal-upload') }
        it { is_expected.to create_service('systemd-journal-upload').with_ensure('running') }
        it { is_expected.to create_service('systemd-journal-upload').with_enable(true) }
      end
    end
  end
end
