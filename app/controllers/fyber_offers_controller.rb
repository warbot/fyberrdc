require 'kaminari'

class FyberOffersController < ApplicationController
  # GET /fyber_offers
  # GET /fyber_offers.json
  def index
    @fyber_offers = fyber_offers
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def fyber_offer_params
    user_params = params.permit(:page, fyber_offers: [:uid, :pub0])
    fyber_params = user_params.fetch(:fyber_offers, {})
    fyber_params = fyber_params.merge(page: user_params[:page] || 1)
    fyber_params
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
