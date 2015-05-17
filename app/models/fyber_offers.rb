class FyberOffers
  include ActiveModel::Validations

  delegate :present?, :blank?, :empty?, :each, :map, to: :offers

  validates :uid, :pub0, presence: true
  validates :page, numericality: {greater_than_or_equal_to: 1}

  def initialize(fyber_offers_api)
    @fyber_offers_api = fyber_offers_api
    @fyber_offers = {}
  end

  def get
    @fyber_offers = parse(@fyber_offers_api.get)

    self
  end

  def uid
    user_params[:uid]
  end

  def pub0
    user_params[:pub0]
  end

  def page
    user_params[:page]
  end

  def offers
    @fyber_offers['offers']
  end

  private

  def parse(serialized_offers)
    JSON.parse(serialized_offers)
  end

  def user_params
    @fyber_offers_api.user_params
  end
end