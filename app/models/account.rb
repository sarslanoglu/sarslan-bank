# frozen_string_literal: true

# Account model for holding balances
class Account < ApplicationRecord
  has_and_belongs_to_many :bank_transactions

  validates_presence_of :name
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
