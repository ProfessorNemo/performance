# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "Event ##{n}" }
    sequence(:starts_at) { |n| (2 * n).days.from_now }
    sequence(:ends_at) { |n| ((2 * n) + 1).days.from_now }
  end
end
