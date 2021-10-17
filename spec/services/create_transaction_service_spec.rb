require 'rails_helper'

RSpec.describe CreateTransactionService do
  subject { described_class.new(user_id: user.id, amount: -100, to_user_id: user2.id, name: 'Паравод другому пользователю').call }

  let(:user) { create(:user, id: '123-123', balance: 1000) }
  let(:user2) { create(:user, id: '345-345', balance: 0)}

  xcontext 'cteate two transaction' do
    it 'create new billing statistic' do
      expect { subject }.to change { Transaction.count }.from(0).to(2)
    end

    it 'fisst transacrion has correct user' do
      subject
      expect(Transaction.first.user).to eq(user)
    end

    it 'last transacrion has correct user' do
      subject
      expect(Transaction.last.user).to eq(user2)
    end

    it 'fisst transacrion has correct amount' do
      subject
      expect(Transaction.first.amount).to eq(-100)
    end

    it 'last transacrion has correct amount' do
      subject
      expect(Transaction.last.amount).to eq(100)
    end

    it 'fisst transacrion has correct name' do
      subject
      expect(Transaction.first.name).to eq('Паравод другому пользователю')
    end

    it 'last transacrion has correct name' do
      subject
      expect(Transaction.last.name).to eq('Паравод другому пользователю')
    end
  end
end
