class CreateTransactionService
  attr_reader :user_id, :to_user_id, :amount, :name

  def initialize(user_id:, amount:, name:, to_user_id: nil)
    @user_id = user_id
    @amount = amount
    @name = name
    @to_user_id = to_user_id
  end

  def call
    transaction_from if transaction_avaible?
    transaction_to if to_user_id.present?
  end

  private

  def transaction_avaible?
    user&.balance + amount >= 0 
  end

  def transaction_from
    Transaction.create(
      user_id: user_id,
      amount: amount,
      name: name,
      billing_at: DateTime.current
    )
    User.transaction(isolation: :serializable) do
      user.balance += amount
      user.save
    end    
  end

  def transaction_to
    Transaction.create(
      user_id: to_user_id,
      amount: -amount,
      name: name,
      billing_at: DateTime.current
    )
    User.transaction(isolation: :serializable) do
      user_to.balance -= amount
      user_to.save
    end    
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def user_to
    @user_to ||= User.find_by(id: to_user_id)
  end
end