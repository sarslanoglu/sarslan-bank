# frozen_string_literal: true

FactoryBot.define do
  factory :bank_transaction do
    credit_account_id { 1 }
    debit_account_id { 2 }
    amount { 100.0 }
  end
end
