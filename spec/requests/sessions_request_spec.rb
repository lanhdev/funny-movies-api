require 'rails_helper'

def decoded_jwt_token_from_response(response)
  token_from_request = response.headers['Authorization'].split(' ').last
  JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)
end

RSpec.describe "Sessions", type: :request do
  context 'POST /sign_in' do
    let(:url) { '/sign_in' }

    context 'when user is new' do
      let(:params) do
        {
          user: attributes_for(:user)
        }
      end

      context 'register new user' do
        before do
          post url, params: params
        end

        it 'returns 201, created' do
          expect(response).to have_http_status(201)
        end

        it 'returns JWT token in authorization header' do
          expect(response.headers['Authorization']).to be_present
        end

        it 'returns valid JWT token' do
          decoded_token = decoded_jwt_token_from_response(response)
          expect(decoded_token.first['sub']).to be_present
        end

        it 'returns a new user' do
          expect(json_response[:username]).to eq params[:user][:username]
        end
      end
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
          post url, params: params
        end

        it 'returns 200, ok' do
          expect(response).to have_http_status(200)
        end

        it 'returns JWT token in authorization header' do
          expect(response.headers['Authorization']).to be_present
        end

        it 'returns valid JWT token' do
          decoded_token = decoded_jwt_token_from_response(response)
          expect(decoded_token.first['sub']).to be_present
        end
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
          post url, params: params
        end

        it 'returns 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns errors' do
          expect(json_response[:errors]).to eq I18n.t(
            'devise.failure.invalid',
            authentication_keys: 'username'
          )
        end
      end
    end
  end

  context 'DELETE /sign_out' do
    let(:url) { '/sign_out' }

    it 'returns 204, no content' do
      delete url
      expect(response).to have_http_status(204)
    end
  end
end
