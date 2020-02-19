# frozen_string_literal: true

# For creating HABTM relation between accounts and bank transactions
class AccountsBankTransaction < ApplicationRecord
  belongs_to :account
  belongs_to :bank_transaction
end
