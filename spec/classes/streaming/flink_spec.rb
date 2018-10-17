require 'spec_helper'
describe 'profiles::streaming::flink' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('profiles::streaming::flink') }
      end
    end
  end
end
