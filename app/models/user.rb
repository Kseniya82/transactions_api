class User < ApplicationRecord
  has_many :transactions
  has_one :billing_statistic
end
