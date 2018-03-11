require 'rails_helper'

RSpec.describe TransactionManager, type: :model do

  range = MonthlySalaryRange.first

  let(:user) {
    User.create!(title: "Mr", firstname: "John", lastname: "Doe",
      city: "San Francisco", birthday: "22/12/1992", monthly_salary_range_id: range.id,
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
  }

  let(:bank_account) {
    BankAccount.create!(branch_code: "92833", sort_code: "02939", account_number: "9384927463Y",
      rib_key: "26", user_id: user.id, balance: 200.0);
  }

  let(:transaction) {
    Transaction.create!(transaction_type: Transaction::CREDIT_TRANSACTION_TYPE,
      state_tid: TransactionState::VALIDATED_STATE_TID, bank_account_id: bank_account.id, value: 100)
  }



  describe "when a validated credit or debit transaction is passed to TransactionManager" do

    it "account balance should be changed accordingly" do
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 300

      transaction.update_attributes(transaction_type: Transaction::DEBIT_TRANSACTION_TYPE, value: 25)
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 275
    end
  end


  describe "when a pending credit or debit transaction is passed to TransactionManager" do

    it "account balance should not be changed" do
      transaction.update_attributes(state_tid: TransactionState::PENDING_STATE_TID)
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 200

      transaction.update_attributes(transaction_type: Transaction::DEBIT_TRANSACTION_TYPE, value: 25)
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 200
    end
  end


  describe "when a cancelled credit or debit transaction is passed to TransactionManager" do

    it "account balance should not be changed" do
      transaction.update_attributes(state_tid: TransactionState::CANCELLED_STATE_TID)
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 200

      transaction.update_attributes(transaction_type: Transaction::DEBIT_TRANSACTION_TYPE, value: 25)
      TransactionManager.new(transaction).execute_transaction
      new_balance = BankAccount.find(transaction.bank_account_id).balance
      expect(new_balance).to be == 200
    end
  end

end
