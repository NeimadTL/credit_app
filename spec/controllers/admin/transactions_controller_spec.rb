require 'rails_helper'

RSpec.describe Admin::TransactionsController, type: :controller do

  range = MonthlySalaryRange.first

  let(:user) {
    User.create!(title: "Mr", firstname: "John", lastname: "Doe",
      city: "San Francisco", birthday: "22/12/1992", monthly_salary_range_id: range.id,
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
  }

  let(:bank_account) {
    BankAccount.create!(branch_code: "92833", sort_code: "02939", account_number: "9384927463Y",
      rib_key: "26", user_id: user.id);
  }


  describe "when GET #index" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http success" do
      user.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :index
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http success" do
      user.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :index
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user is logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when GET #new" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user, returns http success" do
      user.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :new
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http success" do
      user.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :new
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when POST #create" do

    before do
      sign_in(user, nil)
    end

    it "with authorized logged in user and good params, returns http redirect" do
      user.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      post :create,
            transaction: {
              transaction_type: Transaction::CREDIT_TRANSACTION_TYPE,
              state_tid: TransactionState::VALIDATED_STATE_TID,
              bank_account_id: bank_account.id,
              value: 1000
            }
      created_transaction = bank_account.transactions.last
      expect(created_transaction.transaction_type).to be == Transaction::CREDIT_TRANSACTION_TYPE
      expect(created_transaction.state_tid).to be == TransactionState::VALIDATED_STATE_TID
      expect(created_transaction.bank_account_id).to be == bank_account.id
      expect(created_transaction.value).to be == 1000
      expect(flash[:notice]).to match('Transaction crée avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_transactions_path)
    end

    it "with authorized logged in user and bad params, returns http unprocessable_entity" do
      user.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      post :create,
        transaction: {
          transaction_type: nil,
          state_tid: nil,
          bank_account_id: bank_account.id,
          value: nil
        }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end

    it "with unauthorized logged in user, returns http success" do
      user.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :create
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        post :create,
          transaction: {
            transaction_type: Transaction::CREDIT_TRANSACTION_TYPE,
            state_tid: TransactionState::VALIDATED_STATE_TID,
            bank_account_id: bank_account.id,
            value: 1000
          }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
