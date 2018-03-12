require 'rails_helper'

RSpec.describe Admin::BankAccountsController, type: :controller do

  range = MonthlySalaryRange.first

  let(:user) {
    User.create!(title: "Mr", firstname: "John", lastname: "Doe",
      city: "San Francisco", birthday: "22/12/1992", monthly_salary_range_id: range.id,
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
  }

  let(:bank_account) {
    BankAccount.create!(branch_code: "92833", sort_code: "02939", account_number: "9384927463Y",
      rib_key: "26", user_id: user.id, account_state_id: AccountState::PENDING_ACTIVATION_STATE_TID,
      balance: 0.0);
  }

  let(:admin) {
    User.create!(title: "Mr", firstname: "Jimmy", lastname: "Doe",
      city: "New York", birthday: "20/10/1989", email: "admin.jimmy@gmail.com",
      password: "12345678", password_confirmation: "12345678")
  }


  describe "when PUT/PATCH #update" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user and good params, returns http redirect and flashes succes" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      put :update, id: bank_account.id, bank_account: { account_state_id: AccountState::ACTIVE_STATE_TID }
      updated_bank_account = BankAccount.find(bank_account.id)
      expect(updated_bank_account.account_state_id).to be == AccountState::ACTIVE_STATE_TID
      expect(flash[:notice]).to match('Compte mis à jour avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_user_path updated_bank_account.user)
    end


    skip "with authorized logged in user and bad params, returns http redirect and flashes error" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      put :update, id: bank_account.id, bank_account: { account_state_id: 'bad param' }
      expect(flash[:alert]).to match('Une erreur est survenue')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_user_path bank_account.user)
    end

    it "with unauthorized logged in user, render 401 file" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      put :update, id: bank_account.id
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        put :update, id: bank_account.id, bank_account: { account_state_id: AccountState::ACTIVE_STATE_TID }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


end
