
require 'rails_helper'

RSpec.describe Api::V1::BillingStatisticsController, type: :controller do
  let(:user) { create(:user, id: '123-123') }
  let(:billing_statistic) { create(:billing_statistic, user_id: user.id) }

  describe 'GET show' do
    let(:billing_statistic) { create(:billing_statistic, user_id: user.id) }
    let(:params) { { user_id: billing_statistic.user_id } }

    subject(:request) do
      get :show, params: params, format: :json
    end

    it { is_expected.to have_http_status :ok }
  end


  describe 'POST create' do
    before { allow(CreateBillingStatisticJob).to receive(:perform_later).and_return(:billing_statistic)}
    
    let(:transaction) { create(:transaction, user_id: user.id) }
    let(:params) { { data: { user_id: transaction.user_id, date_from: '01.01.2021', date_to: '31.01.2021' } } }

    subject(:request) do
      post :create, params: params, format: :json
    end

    it { is_expected.to have_http_status :ok }
  end
end