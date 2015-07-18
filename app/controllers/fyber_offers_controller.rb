require 'kaminari'

class FyberOffersController < ApplicationController
  # GET /fyber_offers
  # GET /fyber_offers.json
  def index
    @fyber_offers = fyber_offers
    flash[:error] = @fyber_offers.response_errors

    render layout: 'fyber_offers'
  end

  def fyber_offer_params
    user_params = params.permit(:page, fyber_offers: [:uid, :pub0])
    fyber_params = user_params.fetch(:fyber_offers, {})
    fyber_params.merge(page: user_params[:page] || '1')
  end

  def fyber_offers_api
    FyberOffersApi.new(fyber_offer_params)
  end

  def fyber_offers
    fyber_offers = FyberOffers.new(fyber_offers_api)
    if fyber_offers.valid?
      fyber_offers.get
    end
    fyber_offers
  end
end
