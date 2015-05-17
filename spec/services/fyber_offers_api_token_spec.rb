require 'rails_helper'

describe FyberOffersApiToken do
  it 'sorts the params alphabetical asc by keys' do
    params = {b: 2, c: 3, a: 1}
    tokenizer = FyberOffersApiToken.new(params)

    expect(tokenizer.params).to eq(a: 1, b: 2 , c:3)
  end

  describe '#stringify_params' do
    it 'transforms params hash into url like params string' do
      params = {b: 2, c: 3, a: 1}
      tokenizer = FyberOffersApiToken.new(params)

      expect(tokenizer.stringify_params).to eq 'a=1&b=2&c=3'
    end
  end

  describe '#concat_with_api_key' do
    it 'concatenates params with api key' do
      stub_const('FyberOffersApiToken::MY_API_KEY', 'api_key')
      tokenizer = FyberOffersApiToken.new
      params = 'a=1'

      expect(tokenizer.concat_with_api_key(params)).to eq 'a=1&api_key'
    end
  end

  describe '#token' do
    it 'is a sha1 digest' do
      params = {b: 2, c: 3, a: 1}
      tokenizer = FyberOffersApiToken.new(params)
      allow(tokenizer).to receive(:sha1).and_return 'sha1'

      expect(tokenizer.token).to eq 'sha1'
    end
  end
end