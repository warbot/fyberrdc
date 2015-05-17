require 'rails_helper'

describe FyberOffersApi do
  let(:caller) { FyberOffersApi.new }

  it 'exists' do
    expect{FyberOffersApi.new}.not_to raise_exception
  end

  describe '#offers' do
    it 'is ok if all params are valid' do
      response = double 'response', code: 200
      allow(caller).to receive(:get).and_return response

      response = caller.get

      expect(response.code).to be_ok
    end

    it 'is a bad one if one of params is invalid or missing' do
      response = double 'response', code: 400
      allow(caller).to receive(:get).and_return response

      response = caller.get

      expect(response.code).to be_bad
    end

    it 'is an unauthorized if hashkey is invalid' do
      response = double 'response', code: 401
      allow(caller).to receive(:get).and_return response

      response = caller.get

      expect(response.code).to be_unauthorized
    end

    it 'includes offers array' do
      response = {'offers' => %w(offer_1 offer_2)}
      allow(caller).to receive(:get).and_return response

      response = caller.get

      expect(response).to include('offers')
    end

    it 'includes a validation token in response headers' do
      response = double 'response', headers: {x_sponsorpay_response_signature: 1234}
      allow(caller).to receive(:get).and_return response

      response = caller.get

      expect(response.headers).to include(:x_sponsorpay_response_signature)
    end
  end

  describe '#response_valid?' do
    it 'is valid if validator says so' do
      validator = spy 'validator'
      allow(caller).to receive(:get).and_return 'response'
      allow(caller).to receive(:validator).and_return validator
      allow(validator).to receive(:valid?).and_return true

      response = caller.get

      expect(caller.response_valid?(response)).to be_truthy
    end

    it 'is invalid if validator says so' do
      validator = spy 'validator'
      allow(caller).to receive(:get).and_return 'response'
      allow(caller).to receive(:validator).and_return validator
      allow(validator).to receive(:valid?).and_return false

      response = caller.get

      expect(caller.response_valid?(response)).to be_falsey
    end
  end

  describe '#response_token' do
    it 'is nil by default' do
      expect(caller.response_token).to be_nil
    end

    it 'is set after a request' do
      client = double 'client'
      response = double 'response', headers: {x_sponsorpay_response_signature: 123}
      allow(caller).to receive(:client).and_return client
      allow(client).to receive(:get).and_return response

      caller.get

      expect(caller.response_token).to eq 123
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
end