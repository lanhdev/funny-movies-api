# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'when user is new' do
      let(:params) do
        {
          user: attributes_for(:user)
        }
      end

      before do
        post :create, params: params
      end

      it 'returns a new user' do
        expect(json_response[:username]).to eq params[:user][:username]
      end

      it { should respond_with 201 }
    end

    context 'when user is registered' do
      let(:user) { create(:user) }

      context 'when params are correct' do
        let(:params) do
          {
            user: {
              username: user.username,
              password: user.password
            }
          }
        end

        before do
          post :create, params: params
        end

        it 'returns user' do
          expect(json_response[:username]).to eq params[:user][:username]
        end

        it { should respond_with 200 }
      end

      context 'when params are incorrect' do
        let(:params) do
          {
            user: {
              username: user.username,
              password: 'wrong password'
            }
          }
        end

        before do
          post :create, params: params
        end

        it 'returns errors' do
          expect(json_response[:errors]).to eq I18n.t(
            'devise.failure.invalid',
            authentication_keys: 'username'
          )
        end

        it { should respond_with 422 }
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before do
      delete :destroy
    end

    it { should respond_with 204 }
  end
end
