# frozen_string_literal: true

# Account controller for show action
class AccountsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :account_not_found

  before_action :set_account, only: %i[show]

  def show
    @latest_bank_transactions = @account.bank_transactions
                                        .order('bank_transactions.created_at DESC').last(10)
    render json: @account.attributes.merge(transactions: @latest_bank_transactions)
  end

  private

  def account_not_found
    render json: { message: 'Account not found' }, status: 404
  end

  def set_account
    @account = Account.find(params[:id])
  end
end
