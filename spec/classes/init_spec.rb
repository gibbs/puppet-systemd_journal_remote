require 'spec_helper'

# rubocop:disable Layout/FirstArrayElementIndentation
describe 'systemd_journal_remote' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('systemd_journal_remote') }

        it {
          is_expected.to contain_class('systemd_journal_remote::install').
            that_comes_before('Class[systemd_journal_remote::config]')
        }
        it {
          is_expected.to contain_class('systemd_journal_remote::config').
            that_comes_before('Class[systemd_journal_remote::service]')
        }

        it { is_expected.to create_service('systemd-journal-remote') }
        it { is_expected.to create_service('systemd-journal-remote').with_ensure('running') }
        it { is_expected.to create_service('systemd-journal-remote').with_enable(true) }
        it {
          is_expected.to contain_file('/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf')
          verify_contents(catalogue, '/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf', [
            '  --listen-http=-3 \\',
            '  --output=/var/log/journal/remote/',
          ])
        }

        context 'when adding documented journal-remote.conf options' do
          options_fixture = {
            'Seal'      => 'yes',
            'SplitMode' => 'host',
          }

          let(:params) do
            {
              options: options_fixture
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_service('systemd-journal-remote').with(ensure: 'running') }

          options_fixture.each do |key, value|
            it {
              is_expected.to contain_ini_setting(key).with(
                path:    '/etc/systemd/journal-remote.conf',
                section: 'Remote',
                notify:  'Service[systemd-journal-remote]',
                value:   value,
              )
            }
          end
        end

        context 'when adding undocumented journal-remote.conf options' do
          let(:params) do
            {
              options: {
                'UnknownKey' => 'yes',
              }
            }
          end

          it { is_expected.not_to compile.with_all_deps }
        end

        context 'when disabling and stopping the service' do
          let(:params) do
            {
              service_enable: false,
              service_ensure: 'stopped'
            }
          end

          it { is_expected.to create_service('systemd-journal-remote').with_enable(false) }
          it { is_expected.to contain_service('systemd-journal-remote').with(ensure: 'stopped') }
        end

        context 'when using active source configuration' do
          let(:params) do
            {
              command_flags: {
                'url' => 'http://some.host:19531/',
              }
            }
          end

          it {
            is_expected.to contain_file('/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf')
            verify_contents(catalogue, '/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf', [
              '  --url=http://some.host:19531/',
            ])
          }
        end

        context 'when using passive source configuration' do
          let(:params) do
            {
              command_flags: {
                'listen-http' => -3,
                'key'         => '/etc/ssl/private/journal-remote.pem',
                'cert'        => '/etc/ssl/certs/journal-remote.pem',
                'trust'       => '/etc/ssl/ca/trusted.pem',
              }
            }
          end

          it {
            is_expected.to contain_file('/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf')
            verify_contents(catalogue, '/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf', [
              '  --listen-http=-3 \\',
              '  --key=/etc/ssl/private/journal-remote.pem \\',
              '  --cert=/etc/ssl/certs/journal-remote.pem \\',
              '  --trust=/etc/ssl/ca/trusted.pem',
            ])
          }
        end

        context 'when using passive source https configuration' do
          let(:params) do
            {
              command_flags: {
                'listen-https' => 'https://some.host',
                'key'          => '/etc/ssl/private/journal-remote.pem',
                'cert'         => '/etc/ssl/certs/journal-remote.pem',
                'trust'        => 'all',
              }
            }
          end

          it {
            is_expected.to contain_file('/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf')
            verify_contents(catalogue, '/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf', [
              '  --listen-https=https://some.host \\',
              '  --key=/etc/ssl/private/journal-remote.pem \\',
              '  --cert=/etc/ssl/certs/journal-remote.pem \\',
              '  --trust=all',
            ])
          }
        end
      end
    end
  end
end
