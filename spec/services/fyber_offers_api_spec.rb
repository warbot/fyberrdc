require 'rails_helper'

describe FyberOffersApi do
  let(:caller) { FyberOffersApi.new }

  it 'exists' do
    expect{FyberOffersApi.new}.not_to raise_exception
  end

  describe '#offers' do
    it 'is ok' do
      response = caller.offers

      expect(response.code).to be_ok
    end

    it 'includes offers' do
      response = caller.offers

      expect(response).to include('offers')
    end

    it 'includes a validation token in response headers' do
      response = caller.offers

      expect(response.headers).to include(:x_sponsorpay_response_signature)
    end
  end

  describe '#response_valid?' do
    it 'is' do
      response = caller.offers

      expect(caller.response_valid?(response)).to be_truthy
    end
  end

  def be_ok
    eq 200
  end
end