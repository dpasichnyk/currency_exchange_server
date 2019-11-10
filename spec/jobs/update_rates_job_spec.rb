require 'rails_helper'

RSpec.describe UpdateRatesJob, type: :job do
  include ActiveJob::TestHelper

  subject { described_class.perform_later }

  it 'enqueues job in correct queue' do
    expect { subject }.to have_enqueued_job(described_class).on_queue('rates_sync')
  end
end