
require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  let(:user) { create(:user, id: '123-123') }

  describe 'POST create' do
    before { allow(CreateTransactionJob).to receive(:perform_later).and_return(:transaction) }
    let(:transaction) { create(:transaction, user_id: user_id, amount: 100, name: 'Перевод средств') }
    let(:params) { { data: { user_id: user.id, amount: 100, name: 'Перевод средств' } } }

    subject(:request) do
      post :create, params: params, format: :json
    end

    it { is_expected.to have_http_status :ok }
  end
end