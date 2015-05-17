class FyberOffersController < ApplicationController
  # GET /fyber_offers
  # GET /fyber_offers.json
  def index
    @fyber_offers = JSON.parse(FyberOffersApi.new.offers)['offers']
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def fyber_offer_params
      params[:fyber_offer]
    end
end
