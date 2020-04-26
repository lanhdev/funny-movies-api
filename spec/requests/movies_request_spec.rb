require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  context 'GET /movies' do
    let(:url) { '/movies' }
    let!(:movies) { create_list(:movie, 5) }

    context 'when user is not signed in' do
      before do
        get url
      end

      it 'returns 200, ok' do
        expect(response).to have_http_status(200)
      end

      it 'returns movie list' do
        expect(json_response.size).to eq 5
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        sign_in user
        get url
      end

      it 'returns 200, ok' do
        expect(response).to have_http_status(200)
      end

      it 'returns movie list' do
        expect(json_response.size).to eq 5
      end
    end
  end

  context 'POST /movies' do
    let(:url) { '/movies' }
    let(:params) { attributes_for(:movie) }

    context 'when user is not signed in' do
      before do
        post url, params: params
      end

      it 'returns 401, unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      context 'when params are valid' do
        before do
          post url, params: params
        end

        it 'returns 201, created' do
          expect(response).to have_http_status(201)
        end

        it 'returns a new movie' do
          expect(json_response[:url]).to eq params[:url]
        end
      end

      context 'when params are invalid' do
        let(:invalid_params) { { url: nil } }

        before do
          post url, params: invalid_params
        end

        it 'returns 422, unprocessable_entity' do
          expect(response).to have_http_status(422)
        end

        it 'returns errors' do
          expect(json_response[:errors][:url]).to include "can't be blank"
        end
      end
    end
  end
end
