require 'rails_helper'

describe FyberOffersApiValidator do
  describe '#concat_with_api_key' do
    it 'concatenates response with API key' do
      stub_const('FyberOffersApiValidator::MY_API_KEY', 'token')
      response = 'a cool response '
      validator = FyberOffersApiValidator.new

      expect(validator.concat_with_api_key(response)).to eq 'a cool response token'
    end
  end

  describe '#response_hash' do
    it 'converts response to a hash' do
      response = 'response with token'
      validator = FyberOffersApiValidator.new

      expect(validator.response_hash(response)).to eq '0019aa986a0085b762e2e097e534afec4dfc0cd3'
    end
  end

  describe '#valid?' do
    it 'is valid if response token equals calculated token' do
      response_token = '1234'
      validator = FyberOffersApiValidator.new
      allow(validator).to receive(:response_hash).and_return '1234'

      expect(validator.valid?(response_token)).to be_truthy
    end

    it 'is not valid unless response token equals calculated token' do
      response_token = '4321'
      validator = FyberOffersApiValidator.new
      allow(validator).to receive(:response_hash).and_return '1234'

      expect(validator.valid?(response_token)).to be_falsey
    end
  end
end