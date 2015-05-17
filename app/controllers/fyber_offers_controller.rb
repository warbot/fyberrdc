class FyberOffersController < ApplicationController
  # GET /fyber_offers
  # GET /fyber_offers.json
  def index
    @fyber_offers = offers
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def fyber_offer_params
    user_params = params.require(:fyber_offers).permit(:uid, :pub0, :page)
    # user_params[:uid] = user_params[:uid].present? ? user_params[:uid].to_s : 'ted'
    # user_params[:pub0] = user_params[:pub0].present? ? user_params[:pub0] : 'campaign1'
    # user_params[:page] = user_params[:page].present? ? user_params[:page].to_i : 1
    user_params
  end

  def fyber_offers_api
    FyberOffersApi.new(fyber_offer_params)
  end

  def offers
    fyber_offers = FyberOffers.new(fyber_offers_api)
    if fyber_offers.valid?
      fyber_offers.get
    end
    fyber_offers
  end
end
