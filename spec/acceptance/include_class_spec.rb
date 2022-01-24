require 'spec_helper_acceptance'

describe 'include the systemd_journal_remote class' do
  pp = <<-MANIFEST
    include ::systemd_journal_remote
  MANIFEST

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe service('systemd-journal-remote') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe file('/etc/systemd/system/systemd-journal-remote.service.d/service-override.conf') do
    it { is_expected.to be_file }
  end

  describe file('/var/log/journal/') do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by 'root\|systemd-journal' }
    it { is_expected.to be_grouped_into 'root\|systemd-journal' }
  end

  describe file('/var/log/journal/remote/') do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by 'root\|systemd-journal-remote' }
    it { is_expected.to be_grouped_into 'root\|systemd-journal-remote' }
  end
end
