# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankTransaction, type: :model do
  describe 'validations' do
    it { should have_and_belong_to_many(:accounts) }
    it { should validate_numericality_of(:debit_account_id).only_integer }
    it { should validate_numericality_of(:credit_account_id).only_integer }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
