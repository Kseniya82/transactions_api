require 'rails_helper'

RSpec.describe CreateBillingStatisticJob, type: :job do
  let(:service) { double('CreateBillingStatisticService') }
  let(:params) do
    {
      user_id: '123-233',
      date_from: '01.01.2021',
      date_to: '05.01.2021'
    }
  end

  before do
    allow(CreateBillingStatisticService).to receive(:new).and_return(service)
  end

  it 'calls CreateBillingStatisticService' do
    expect(service).to receive(:call)
    CreateBillingStatisticJob.perform_now(params)
  end
end
