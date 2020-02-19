# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET show' do
    it 'should return show account success' do
      account = create(:account)
      get :show, params: { id: account.id }
      expect(response).to be_successful
    end

    it 'should return 404 for unknown id' do
      get :show, params: { id: -1 }
      expect(response).to have_http_status(404)
    end
  end
end
