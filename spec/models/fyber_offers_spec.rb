require 'rails_helper'

describe FyberOffers do
  it 'gets the offer using fyber offers api' do
    FyberOffers.new(fyber_offers_api).get

    expect(fyber_offers_api).to have_received(:get)
  end

  it 'assigns offers to offers' do
    fyber_offers = FyberOffers.new(fyber_offers_api).get

    expect(fyber_offers.offers).to eq [1, 2]
  end

  it 'iterates through offers by map or each' do
    fyber_offers = FyberOffers.new(fyber_offers_api).get

    offers = fyber_offers.map(&:to_s)

    expect(offers).to eq %w(1 2)
  end

  describe '#uid' do
    it 'returns uid' do
      fyber_offers_api = spy('fyber_offers_api', user_params: {uid: '1'})
      fyber_offers = FyberOffers.new(fyber_offers_api)

      expect(fyber_offers.uid).to eq '1'
    end
  end

  describe '#pub0' do
    it 'returns pub0' do
      fyber_offers_api = spy('fyber_offers_api', user_params: {pub0: '0'})
      fyber_offers = FyberOffers.new(fyber_offers_api)

      expect(fyber_offers.pub0).to eq '0'
    end
  end

  describe '#page' do
    it 'returns page converted to integer' do
      fyber_offers_api = spy('fyber_offers_api', user_params: {page: '2'})
      fyber_offers = FyberOffers.new(fyber_offers_api)

      expect(fyber_offers.page).to eq 2
    end

    it 'returns 0 if response was corrupted' do
      fyber_offers_api = spy('fyber_offers_api', user_params: {page: :ktulhu})
      fyber_offers = FyberOffers.new(fyber_offers_api)

      expect(fyber_offers.page).to eq 1
    end

    it 'returns 0 by default' do
      get_response = {}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.items_on_page).to eq 0
    end
  end

  describe '#pages' do
    it 'returns total number of pages' do
      get_response = {offers: [1, 2], pages: 1}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.pages).to eq 1
    end

    it 'returns 0 by default' do
      get_response = {}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.items_on_page).to eq 0
    end
  end

  describe '#items_on_page' do
    it 'returns total number of items at page' do
      get_response = {offers: [1, 2], count: 20}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.items_on_page).to eq 20
    end

    it 'returns 0 by default' do
      get_response = {}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.items_on_page).to eq 0
    end
  end

  describe '#count' do
    it 'returns total amount of items from response' do
      get_response = {offers: [1, 2], count: 20, pages: 2}.to_json
      fyber_offers_api = spy('fyber_offers_api', get: get_response)
      fyber_offers = FyberOffers.new(fyber_offers_api)

      fyber_offers.get

      expect(fyber_offers.count).to eq 40
    end
  end

  describe '#response_errors' do
    it 'returns total amount of items from response' do
      fyber_offers_api = spy('fyber_offers_api')
      fyber_offers = FyberOffers.new(fyber_offers_api)
      allow(fyber_offers_api).to receive(:response_errors).and_return 'my bad'

      expect(fyber_offers.response_errors).to eq 'my bad'
    end
  end

  describe '#parse' do
    it 'parse the json' do
      json = {name: 'is jonas'}.to_json
      fyber_offers_api = spy('fyber_offers_api')
      fyber_offers = FyberOffers.new(fyber_offers_api)

      parsed = fyber_offers.parse(json)

      expect(parsed).to eq('name' => 'is jonas')
    end

    it 'returns empty_fyber_offers in case of response cannot be parsed' do
      invalid_json = 'something'
      fyber_offers_api = spy('fyber_offers_api')
      fyber_offers = FyberOffers.new(fyber_offers_api)

      parsed = fyber_offers.parse(invalid_json)

      expect(parsed).to eq({})
    end
  end

  def fyber_offers_api
    get_response = {offers: [1, 2]}.to_json
    @fyber_offers_api ||= spy('fyber_offers_api', get: get_response)
  end
end