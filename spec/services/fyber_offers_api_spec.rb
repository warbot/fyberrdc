require 'rails_helper'

describe FyberOffersApi do
  let(:api) { FyberOffersApi.new }

  it 'exists' do
    expect{FyberOffersApi.new}.not_to raise_exception
  end

  describe '#get' do
    it 'is ok if all params are valid' do
      response = double 'response', code: 200
      allow(api).to receive(:get_response).and_return response
      allow(api).to receive(:response_valid?).and_return true

      response = api.get

      expect(response.code).to be_ok
    end

    it 'is a bad one if one of params is invalid or missing' do
      response = double 'response', code: 400
      allow(api).to receive(:get_response).and_return response
      allow(api).to receive(:response_valid?).and_return true

      response = api.get

      expect(response.code).to be_bad
    end

    it 'is an unauthorized if hashkey is invalid' do
      response = double 'response', code: 401
      allow(api).to receive(:get_response).and_return response
      allow(api).to receive(:response_valid?).and_return true

      response = api.get

      expect(response.code).to be_unauthorized
    end

    it 'includes offers array' do
      response = {'offers' => %w(offer_1 offer_2)}
      allow(api).to receive(:get_response).and_return response
      allow(api).to receive(:response_valid?).and_return true

      response = api.get

      expect(response).to include('offers')
    end

    it 'includes a validation token in response headers' do
      response = double 'response', headers: {x_sponsorpay_response_signature: 1234}
      allow(api).to receive(:get_response).and_return response

      response = api.get

      expect(response.headers).to include(:x_sponsorpay_response_signature)
    end

    it 'adds error if response was not valid' do
      response = double 'response', code: 200
      allow(api).to receive(:get_response).and_return response
      allow(api).to receive(:response_valid?).and_return false

      response = api.get

      expect(api.response_errors).to eq not_valid_response_message
    end
  end

  describe '#response_valid?' do
    it 'is valid if validator says so' do
      validator = spy 'validator'
      allow(api).to receive(:get).and_return 'response'
      allow(api).to receive(:validator).and_return validator
      allow(validator).to receive(:valid?).and_return true

      response = api.get

      expect(api.response_valid?(response)).to be_truthy
    end

    it 'is invalid if validator says so' do
      validator = spy 'validator'
      allow(api).to receive(:get).and_return 'response'
      allow(api).to receive(:validator).and_return validator
      allow(validator).to receive(:valid?).and_return false

      response = api.get

      expect(api.response_valid?(response)).to be_falsey
    end
  end

  describe '#response_token' do
    it 'is nil by default' do
      expect(api.response_token).to be_nil
    end

    it 'is set after a request' do
      client = double 'client'
      response = double 'response', headers: {x_sponsorpay_response_signature: 123}
      allow(api).to receive(:client).and_return client
      allow(client).to receive(:get).and_return response

      api.get

      expect(api.response_token).to eq 123
    end
  end

  def be_ok
    eq 200
  end

  def be_bad
    eq 400
  end

  def be_unauthorized
    eq 401
  end

  def not_valid_response_message
    I18n.t('fyber_offers_api.repsonse.not_valid')
  end
end