require 'rails_helper'

RSpec.describe FyberOffersController do
  describe 'index' do
    it 'renders fyber_offers template' do
      get :index

      expect(response).to render_template(:fyber_offers)
    end

    it 'shows the response_error' do
      fyber_offers = double(:fyber_offers, response_errors: 'error')
      allow(controller).to receive(:fyber_offers).and_return fyber_offers

      get :index

      expect(flash[:error]).to eq 'error'
    end

    it 'checks if params are valid before making request' do
      fyber_offers = double(:fyber_offers, response_errors: 'error')
      allow(FyberOffers).to receive(:new).and_return fyber_offers
      allow(fyber_offers).to receive(:valid?)
      allow(fyber_offers).to receive(:get)

      get :index

      expect(fyber_offers).to have_received(:valid?)
      expect(fyber_offers).not_to have_received(:get)
    end

    it 'does api call if params are valid' do
      fyber_offers = double(:fyber_offers, response_errors: 'error')
      allow(FyberOffers).to receive(:new).and_return fyber_offers
      allow(fyber_offers).to receive(:valid?).and_return true
      allow(fyber_offers).to receive(:get)

      get :index

      expect(fyber_offers).to have_received(:valid?)
      expect(fyber_offers).to have_received(:get)
    end
  end

  describe '#fyber_offer_params' do
    it 'exclude params except page, uid and pub0' do
      get :index, {other: 0, page: 1, fyber_offers: {uid: 2, pub0: 3, another: 4}}

      params = controller.fyber_offer_params

      expect(params).to match({page: '1', uid: '2', pub0: '3'})
    end

    it 'set page to 1 if it is absent' do
      get :index

      params = controller.fyber_offer_params

      expect(params).to match({page: '1'})
    end
  end
end
