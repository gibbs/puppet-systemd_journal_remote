require 'spec_helper'

# rubocop:disable Layout/FirstArrayElementIndentation
describe 'systemd_journal_remote::gatewayd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        distro = facts[:os]['distro']['id'] + facts[:os]['distro']['release']['major']

        # Catalogue compilation
        it { is_expected.to compile.with_all_deps }

        # Classes
        it { is_expected.to create_class('systemd_journal_remote') }
        it { is_expected.to create_class('systemd_journal_remote::gatewayd') }
        it {
          is_expected.to contain_class('systemd_journal_remote::gatewayd::config')
            .that_comes_before('Class[systemd_journal_remote::gatewayd::service]')
        }
        it { is_expected.to create_class('systemd_journal_remote::gatewayd::config') }
        it { is_expected.to create_class('systemd_journal_remote::gatewayd::service') }

        # Service
        it { is_expected.to create_service('systemd-journal-gatewayd') }
        it { is_expected.to create_service('systemd-journal-gatewayd').with_ensure('running') }
        it { is_expected.to create_service('systemd-journal-gatewayd').with_enable(true) }

        # Service dropin file
        it { is_expected.to contain_systemd__dropin_file('systemd_journal_remote-gatewayd_dropin') }
        it {
          is_expected.to contain_file('/etc/systemd/system/systemd-journal-gatewayd.service.d/service-override.conf')
        }
      end
    end
  end
end
