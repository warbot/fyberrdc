class FyberOffers
  include ActiveModel::Validations

  delegate :present?, :blank?, :empty?, :any?, :each, :map, to: :offers

  validates :uid, :pub0, presence: true
  validates :page, numericality: {greater_than_or_equal_to: 1}
  validate :no_response_errors?

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
    begin
      user_params[:page].to_i
    rescue
      1
    end
  end
  alias :current_page :page

  def offers
    @fyber_offers['offers'] || []
  end

  def pages
    @fyber_offers['pages'] || 0
  end
  alias :total_pages :pages

  def items_on_page
    @fyber_offers['count'] || 0
  end
  alias :limit_value :items_on_page

  def count
    limit_value * pages
  end

  def response_errors
    @fyber_offers_api.response_errors
  end

  def parse(response)
    begin
      JSON.parse(response)
    rescue
      {}
    end
  end

  private

  def user_params
    @fyber_offers_api.user_params
  end

  def no_response_errors?
    response_errors.blank?
  end
end