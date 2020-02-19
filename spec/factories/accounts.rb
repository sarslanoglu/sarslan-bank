# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence :name do |n|
      "account#{n}"
    end
    balance { 1000.0 }
  end
end
