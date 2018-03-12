require 'rails_helper'
require 'date'

RSpec.describe Admin::UsersController, type: :controller do


  let(:admin) {
    User.create!(title: "Mr", firstname: "John", lastname: "Doe",
      city: "San Francisco", birthday: "22/12/1992", email: "something@gmail.com",
      password: "12345678", password_confirmation: "12345678")
  }

  range = MonthlySalaryRange.first

  let(:client) {
    User.create!(title: "Mr", firstname: "Jimmy", lastname: "Newman",
      city: "Seattle", birthday: "12/10/1872", monthly_salary_range_id: range.id,
      email: "jimmy.newman@gmail.com", password: "12345678", password_confirmation: "12345678")
  }


  describe "when GET #index" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user, returns http success" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :index
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http success" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :index
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user is logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when GET #edit" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user, returns http success" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :edit, id: client.id
      expect(response).to have_http_status(:success)
    end

    it "with unauthorized logged in user, returns http success" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :edit, id: client.id
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        get :edit, id: client.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when PUT/PATCH #update" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user and good params, returns http redirect" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      post :update, id: client.id,
            user: {
              title: 'Mlle',
              firstname: 'Lauren',
              lastname: 'Miles',
              birthday: Date.parse('30/08/1909'),
              email: 'lauren.miles@gmail.com',
              city: 'Boston',
              monthly_salary_range_id: MonthlySalaryRange::BETWEEN_2000_AND_2999_RANGE_TID
            }
      updated_client = User.find(client.id)
      expect(updated_client.title).to eql 'Mlle'
      expect(updated_client.firstname).to eql 'Lauren'
      expect(updated_client.lastname).to eql 'Miles'
      expect(updated_client.birthday).to be == Date.parse('30/08/1909')
      expect(updated_client.email).to eql 'lauren.miles@gmail.com'
      expect(updated_client.city).to eql 'Boston'
      expect(updated_client.monthly_salary_range_id).to be == MonthlySalaryRange::BETWEEN_2000_AND_2999_RANGE_TID
      expect(flash[:notice]).to match('Client mis à jour avec succès')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_users_path)
    end

    it "with authorized logged in user and bad params, returns http unprocessable_entity" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      post :update, id: client.id,
            user: {
              title: nil,
              firstname: nil,
              lastname: nil,
              birthday: nil,
              email: nil,
              city: nil,
              monthly_salary_range_id: MonthlySalaryRange::BETWEEN_2000_AND_2999_RANGE_TID
            }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end

    it "with unauthorized logged in user, render 401 file" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :update, id: client.id
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end

    describe "with no user logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        post :update, id: client.id,
              user: {
                title: 'Mlle',
                firstname: 'Lauren',
                lastname: 'Miles',
                birthday: Date.parse('30/08/1909'),
                email: 'lauren.miles@gmail.com',
                city: 'Boston',
                monthly_salary_range_id: MonthlySalaryRange::BETWEEN_2000_AND_2999_RANGE_TID
              }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "when GET #show" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user, returns http success" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :show, id: client.id
      expect(response).to have_http_status(:success)
    end

    it "with authorized logged in user and nonexistent resource, renders 404.html file" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :show, id: Random.new.rand(2000..3000)
      expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
    end

    it "with unauthorized logged in user, renders 401.html file" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :show, id: client.id
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end


    describe "with no user logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        get :show, id: client.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "when DELETE #destroy" do

    before do
      sign_in(admin, nil)
    end

    it "with authorized logged in user, returns http redirect" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :destroy, id: client.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_users_path)
    end

    it "with authorized logged in user and nonexistent resource, renders 404.html file" do
      admin.update_attributes(role_tid: Role::ADMIN_ROLE_TID)
      get :destroy, id: Random.new.rand(2000..3000)
      expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
    end

    it "with unauthorized logged in user, renders 401.html file" do
      admin.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
      get :destroy, id: client.id
      expect(response).to render_template(:file => "#{Rails.root}/public/401.html")
    end


    describe "with no user logged in," do

      before do
        sign_out(admin)
      end

      it "returns http redirect" do
        get :destroy, id: client.id
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
