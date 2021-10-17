require 'rails_helper'

RSpec.describe CreateTransactionJob, type: :job do
  let(:service) { double('CreateTransactionService') }
  let(:params) do
    {
      user_id: '123-233',
      name: 'Оптлата покупки',
      amount: -400.00
    }
  end

  before do
    allow(CreateTransactionService).to receive(:new).and_return(service)
  end

  it 'calls CreateTransactionService' do
    expect(service).to receive(:call)
    CreateTransactionJob.perform_now(params)
  end
end
