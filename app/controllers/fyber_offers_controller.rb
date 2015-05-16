class FyberOffersController < ApplicationController
  before_action :set_fyber_offer, only: [:show, :edit, :update, :destroy]

  # GET /fyber_offers
  # GET /fyber_offers.json
  def index
    @fyber_offers = FyberOffer.all
  end

  # GET /fyber_offers/1
  # GET /fyber_offers/1.json
  def show
  end

  # GET /fyber_offers/new
  def new
    @fyber_offer = FyberOffer.new
  end

  # GET /fyber_offers/1/edit
  def edit
  end

  # POST /fyber_offers
  # POST /fyber_offers.json
  def create
    @fyber_offer = FyberOffer.new(fyber_offer_params)

    respond_to do |format|
      if @fyber_offer.save
        format.html { redirect_to @fyber_offer, notice: 'Fyber offer was successfully created.' }
        format.json { render :show, status: :created, location: @fyber_offer }
      else
        format.html { render :new }
        format.json { render json: @fyber_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fyber_offers/1
  # PATCH/PUT /fyber_offers/1.json
  def update
    respond_to do |format|
      if @fyber_offer.update(fyber_offer_params)
        format.html { redirect_to @fyber_offer, notice: 'Fyber offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @fyber_offer }
      else
        format.html { render :edit }
        format.json { render json: @fyber_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fyber_offers/1
  # DELETE /fyber_offers/1.json
  def destroy
    @fyber_offer.destroy
    respond_to do |format|
      format.html { redirect_to fyber_offers_url, notice: 'Fyber offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fyber_offer
      @fyber_offer = FyberOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fyber_offer_params
      params[:fyber_offer]
    end
end
