FactoryBot.define do
  factory :rates_history do
    transient do
      sequence :n
    end

    date { Date.today - n.days }

    from_currency { 'EUR' }
    to_currency { 'USD' }
    rate { 1.222222 }
  end
end