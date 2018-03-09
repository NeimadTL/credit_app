require 'rails_helper'

RSpec.describe Client::BankAccountsController, type: :controller do

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

    it "with logged in user, returns http success" do
      get :index
      expect(response).to have_http_status(:success)
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

    it "with logged in user, returns http success" do
      get :new
      expect(response).to have_http_status(:success)
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

    it "with logged in user and good params, returns http redirect" do
      post :create,
            bank_account: {
              branch_code: '12345',
              sort_code: '67891',
              account_number: '2345678912E',
              rib_key: '34'
            }
      created_bank_account = BankAccount.last
      expect(created_bank_account.branch_code).to eq '12345'
      expect(created_bank_account.sort_code).to eq '67891'
      expect(created_bank_account.account_number).to eq '2345678912E'
      expect(created_bank_account.rib_key).to eq '34'
      expect(created_bank_account.user_id).to be == user.id
      expect(flash[:notice]).to match('Compte crée avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(client_bank_accounts_path)
    end

    it "with logged in user and bad params, returns http unprocessable_entity" do
      post :create, bank_account: { branch_code: nil, sort_code: nil, account_number: nil, rib_key: nil }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http redirect" do
        post :create,
              bank_account: {
                branch_code: '12345',
                sort_code: '67891',
                account_number: '2345678912E',
                rib_key: '34'
              }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end


  describe "when GET #show" do

    before do
      sign_in(user, nil)
    end

    it "with logged in user, returns http success" do
      get :show, id: bank_account.id
      expect(response).to have_http_status(:success)
    end

    it "with nonexistent resource, renders 404.html file" do
      get :show, id: Random.new.rand(2000..3000)
      expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(user)
      end

      it "returns http success" do
        get :show, id: bank_account.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


end
