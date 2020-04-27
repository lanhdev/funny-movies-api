# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    let!(:movies) { create_list(:movie, 5) }

    before(:each) do
      get :index
    end

    it 'returns 5 records from database' do
      movies_responses = json_response
      expect(movies_responses.size).to eq 5
    end

    it 'has the username as a embedded object' do
      movies_responses = json_response
      movies_responses.each do |movie_response|
        expect(movie_response[:username]).to be_present
      end
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do
    sign_in_user

    context 'when is successfully created' do
      let(:movie_attributes) { attributes_for(:movie) }

      before(:each) do
        post :create, params: movie_attributes
      end

      it 'renders the json representation for the movie record just created' do
        movies_response = json_response
        expect(movies_response[:url]).to eq movie_attributes[:url]
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do
      let(:invalid_movie_attributes) { attributes_for(:movie, url: nil) }

      before(:each) do
        post :create, params: invalid_movie_attributes
      end

      it 'renders an errors json' do
        movies_response = json_response
        expect(movies_response).to have_key(:errors)
      end

      it 'renders the json errors on why the movie could not be created' do
        movies_response = json_response
        expect(movies_response[:errors][:url]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
