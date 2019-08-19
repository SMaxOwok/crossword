FactoryBot.define do
  factory :puzzle do
    source { 'nyt' }
    date { Date.today }
    completed { true }
  end
end
