FactoryBot.define do
  factory :puzzle do
    source { 'nyt' }
    date { Date.today }
    completed { true }
    hours { rand(0..1) }
    minutes { rand(0..59) }
    seconds { rand(0..59) }
  end
end
