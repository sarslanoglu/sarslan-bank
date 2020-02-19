# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionService do
  describe '#create_transaction' do
    it 'should return same account error when there is only one account' do
      account = create(:account)

      params = { debit_account_id: account.id,
                 credit_account_id: account.id,
                 amount: 1200.0 }

      expect {
        TransactionService.new(params).create_transaction
      }.to change(BankTransaction, :count).by(0)
    end

    it 'should return insufficient_balance error when there is not enough balance' do
      debit_account = create(:account)
      credit_account = create(:account)

      params = { debit_account_id: debit_account.id,
                 credit_account_id: credit_account.id,
                 amount: 1200.0 }

      expect {
        TransactionService.new(params).create_transaction
      }.to change(BankTransaction, :count).by(0)
    end

    it 'should create transaction and corresponding data' do
      debit_account = create(:account)
      credit_account = create(:account)

      params = { debit_account_id: debit_account.id,
                 credit_account_id: credit_account.id,
                 amount: 120.0 }

      expect {
        TransactionService.new(params).create_transaction
      }.to change(BankTransaction, :count).by(1)

      debit_account.reload
      credit_account.reload

      expect(debit_account.balance).to eq(1120.0)
      expect(credit_account.balance).to eq(880.0)
      expect(debit_account.bank_transactions.size).to be(1)
      expect(debit_account.bank_transactions.size).to be(1)
    end
  end
end
