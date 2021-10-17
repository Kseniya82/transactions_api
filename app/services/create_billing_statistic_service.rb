class CreateBillingStatisticService
  attr_reader :user_id, :date_from, :date_to
  attr_accessor :sum_balance

  def initialize(user_id:, date_from:, date_to:)
    @date_from = date_from.to_date.beginning_of_day
    @date_to = date_to.to_date.end_of_day
    @user_id = user_id
    @sum_balance = 0
  end

  def call
    statistic = BillingStatistic.find_by(user_id: user_id) || BillingStatistic.new(user_id: user_id)
    statistic.update(
      content: content,
      date_from: date_from.to_date,
      date_to: date_to.to_date,
    )
  end

  private

  def content
    { transactions: transactions }.merge(
      {
        balance_date_from: balance_date_from,
        balance_date_to: balance_date_to,  
        date_from: date_from.to_date,
        date_to: date_to.to_date,     
      }
    )   
  end

  def balance_date_from
    current_balance - balance_date_to_diffirence - sum_balance
  end

  def balance_date_to
    current_balance - balance_date_to_diffirence
  end

  def balance_date_to_diffirence
    end_date = user.updated_at
    Transaction.where(user_id: user_id, billing_at: date_to..end_date).sum(:amount)
  end
 
  def current_balance
    user.balance
  end

  def request_transactions
    Transaction.where(billing_at: date_from..date_to, user_id: user_id)
  end

  def transactions
    request_transactions.find_all.map do |transaction|
      @sum_balance += transaction.amount
      {
        name: transaction.name,
        billing_at: transaction.billing_at.to_s,
        amount: transaction.amount
      }
    end
  end

  def user
    @user ||= User.find_by(id: user_id)
  end
end