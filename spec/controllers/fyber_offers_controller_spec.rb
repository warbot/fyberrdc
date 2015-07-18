require 'rails_helper'

RSpec.describe FyberOffersController do
  describe 'index' do
    it 'renders fyber_offers' do
      get :index

      expect(response).to render_template(:fyber_offers)
    end

    it 'shows the response_error' do
      fyber_offers = double(:fyber_offers, response_errors: 'error')
      allow(controller).to receive(:fyber_offers).and_return fyber_offers

      get :index

      expect(flash[:error]).to eq 'error'
    end
  end
end
