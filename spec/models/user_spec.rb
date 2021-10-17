require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:uer) }

  it { is_expected.to have_many(:transactions) }
  it { is_expected.to have_one(:billing_statistic) }
end
