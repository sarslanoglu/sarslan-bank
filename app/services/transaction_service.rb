# frozen_string_literal: true

# Transaction service for creating bank transactions
class TransactionService
  def initialize(params)
    @debit_account_id = params[:debit_account_id]
    @credit_account_id = params[:credit_account_id]
    @amount = params[:amount].to_d
  end

  def create_transaction
    @credit_account = Account.find(@credit_account_id)
    @debit_account = Account.find(@debit_account_id)

    return 'insufficient_balance' if insufficient_balance_of_credit_account

    begin
      @transaction = BankTransaction.new(debit_account_id: @debit_account_id,
                                         credit_account_id: @credit_account_id,
                                         amount: @amount)
      regulate_balances if @transaction.save!
      create_transaction_records
    rescue StandardError => e
      e
    end
  end

  private

  def insufficient_balance_of_credit_account
    @credit_account.balance < @amount
  end

  def regulate_balances
    @credit_account.balance -= @amount
    @credit_account.save!
    @debit_account.balance += @amount
    @debit_account.save!
  end

  def create_transaction_records
    credit_transaction_record = AccountsBankTransaction.new(account_id: @credit_account_id,
                                                            bank_transaction_id: @transaction.id)
    debit_transaction_record = AccountsBankTransaction.new(account_id: @debit_account_id,
                                                           bank_transaction_id: @transaction.id)
    credit_transaction_record.save!
    debit_transaction_record.save!
  end
end
