# frozen_string_literal: true

# For creating bank transaction
class BankTransactionsController < ApplicationController
  def create
    if params[:debit_account_id].present? &&
       params[:credit_account_id].present? &&
       params[:amount].present?
      create_transaction(params)
    else
      render status: '400', json: { message: 'Missing parameter or parameters' }.to_json
    end
  end

  private

  def create_transaction(params)
    transaction_process = initialize_transaction(params)

    if transaction_process == 'insufficient_balance'
      render status: '422', json: { message: 'Insufficient balance at credit account' }.to_json
    elsif transaction_process == 'same_account'
      render status: '422', json: { message: 'Credit and debit account can not be same' }.to_json
    elsif transaction_process == true
      render status: '201', json: { message: 'Transaction created successfully' }.to_json
    else
      render status: '500', json: { message: transaction_process }.to_json
    end
  end

  def initialize_transaction(params)
    TransactionService.new(params).create_transaction
  end
end
