class CreateBankTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_transactions do |t|
      t.integer :debit_account_id
      t.integer :credit_account_id
      t.decimal :amount

      t.timestamps
    end

    create_table :accounts_bank_transactions do |t|
      t.integer :account_id
      t.integer :bank_transaction_id
    end

    add_index :accounts_bank_transactions, [:account_id, :bank_transaction_id], name: 'index_on_account_id_and_bank_transaction_id'
  end
end
