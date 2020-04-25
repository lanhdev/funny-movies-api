require 'rails_helper'

def decoded_jwt_token_from_response(response)
  token_from_request = response.headers['Authorization'].split(' ').last
  JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)
end

RSpec.describe "Sessions", type: :request do
  context 'POST /auth/sign_in' do
    let(:url) { '/auth/sign_in' }

    context 'when user is new' do
      let(:params) do
        {
          user: {
            email: Faker::Internet.email,
            password: '12345678'
          }
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
          user = JSON.parse(response.body)
          expect(user).to include('id', 'email')
        end
      end
    end

    context 'when user is registered' do
      let(:user) { create(:user) }

      context 'when params are correct' do
        let(:params) do
          {
            user: {
              email: user.email,
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
              email: user.email,
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
          json_response = JSON.parse(response.body)
          expect(json_response['errors']).to eq 'Invalid email or password'
        end
      end
    end
  end

  context 'DELETE /auth/signout' do
    let(:url) { '/auth/sign_out' }

    it 'returns 204, no content' do
      delete url
      expect(response).to have_http_status(204)
    end
  end
end
