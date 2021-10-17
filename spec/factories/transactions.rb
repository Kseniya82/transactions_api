FactoryBot.define do
  factory :transaction do
    amount { rand(-1000..1000) }
    user { "" }
    billing_at { "#{rand(1..31)}.01.2021".to_date.middle_of_day }
  end
end
