require 'rails_helper'

describe FyberOffers do
  it 'gets the offer using fyber offers api' do
    allow(fyber_offers_api).to receive(:get).and_return '{"offers":[1,2]}'

    FyberOffers.new(fyber_offers_api).get

    expect(fyber_offers_api).to have_received(:get)
  end

  it 'assigns offers to offers' do
    fyber_offers = FyberOffers.new(fyber_offers_api).get

    expect(fyber_offers.offers).to eq [1, 2]
  end

  it 'responds to uid' do
    fyber_offers = FyberOffers.new(fyber_offers_api)

    expect(fyber_offers).to respond_to(:uid)
  end

  it 'responds to pub0' do
    fyber_offers = FyberOffers.new(fyber_offers_api)

    expect(fyber_offers).to respond_to(:pub0)
  end

  it 'responds to page' do
    fyber_offers = FyberOffers.new(fyber_offers_api)

    expect(fyber_offers).to respond_to(:page)
  end

  it 'iterates through offers by map or each' do
    fyber_offers = FyberOffers.new(fyber_offers_api).get

    offers = fyber_offers.map(&:to_s)

    expect(offers).to eq %w(1 2)
  end

  def fyber_offers_api
    json_offers = '{"offers":[1,2]}'
    @fyber_offers_api ||= spy('fyber_offers_api', get: json_offers)
  end
end