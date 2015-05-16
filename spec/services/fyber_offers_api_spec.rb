require 'rails_helper'

describe FyberOffersApi do
  let(:caller) { FyberOffersApi.new }

  it 'exists' do
    expect{FyberOffersApi.new}.not_to raise_exception
  end

  describe '#offers' do
    xit 'is ok' do
      response = caller.offers

      expect(response.code).to be_ok
    end

    it 'includes offers' do
      response = caller.offers

      expect(response).to include('offers')
    end
  end

  def be_ok
    eq 200
  end
end