FactoryBot.define do
  factory :game do
    started_at { nil }
    ended_at { nil }
    player_count { 2 }
  end
end
