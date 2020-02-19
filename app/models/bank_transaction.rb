# frozen_string_literal: true

# For transfering money between accounts
class BankTransaction < ApplicationRecord
  has_and_belongs_to_many :accounts

  validates :debit_account_id, allow_blank: true, numericality: { only_integer: true }
  validates :credit_account_id, allow_blank: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
