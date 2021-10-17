require 'rails_helper'

RSpec.describe CreateBillingStatisticService do
  subject { described_class.new(user_id: user.id, date_from: '01.01.2021', date_to: '01.02.2021').call }

  let!(:transactions_list) do
    create_list(
      :transaction,
      4,
      user_id: user.id
    )
  end

  let(:user) { create(:user, id: '123-123', balance: 1000) }

  let(:transactions) do
    transactions_list.map do |transaction|
      {
        name: transaction.name,
        billing_at: transaction.billing_at.to_s,
        amount: transaction.amount.to_f.to_s
      }.stringify_keys
    end
  end

  let(:sum_balance) { transactions_list.sum { _1.amount.to_f } }
  let(:balance_date_from) { (user.balance - sum_balance).to_f }

  let(:content) do
    { transactions: transactions,
      balance_date_from: balance_date_from.to_s,
      balance_date_to: user.balance.to_f.to_s,
      date_from: '01.01.2021'.to_date.to_s,
      date_to: '01.02.2021'.to_date.to_s,      
    }.stringify_keys
  end

  context 'cteate billing statistics' do
    it 'create new billing statistic' do
      expect { subject }.to change { BillingStatistic.count }.from(0).to(1)
    end

    it 'billing statistic have correct content' do
      subject
      expect(BillingStatistic.last.content).to eq(content)
    end

    it 'billing statistic have correct date_from' do
      subject
      expect(BillingStatistic.last.date_from).to eq('01.01.2021'.to_date)
    end

    it 'billing statistic have correct date_to' do
      subject
      expect(BillingStatistic.last.date_to).to eq('01.02.2021'.to_date)
    end

    it 'billing statistic have correct user' do
      subject
      expect(BillingStatistic.last.user).to eq(user)
    end
  end
end
