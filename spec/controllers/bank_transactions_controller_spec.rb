# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankTransactionsController, type: :controller do
  describe 'POST create' do
    context 'should call transaction service'
    it 'shows success result' do
      debit_account = create(:account)
      credit_account = create(:account)
      post :create, params: { debit_account_id: debit_account.id,
                              credit_account_id: credit_account.id,
                              amount: 126.82 }

      expect(response).to have_http_status(:created)
    end

    it 'shows same_account error' do
      account = create(:account)
      post :create, params: { debit_account_id: account.id,
                              credit_account_id: account.id,
                              amount: 1260.82 }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'shows insufficient_balance error' do
      debit_account = create(:account)
      credit_account = create(:account)
      post :create, params: { debit_account_id: debit_account.id,
                              credit_account_id: credit_account.id,
                              amount: 1260.82 }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'shows 500 error' do
      debit_account = create(:account)
      credit_account = create(:account)
      post :create, params: { debit_account_id: debit_account.id.to_d,
                              credit_account_id: credit_account.id,
                              amount: 126.82 }

      expect(response).to have_http_status(:internal_server_error)
    end

    it 'should give error' do
      post :create, params: { amount: '' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
