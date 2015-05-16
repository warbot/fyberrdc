require 'rails_helper'

describe FyberOffersApiValidator do
  it 'concatenates response with API key' do
    stub_const('FyberOffersApiValidator::MY_API_KEY', 'token')
    response = 'a cool response '
    validator = FyberOffersApiValidator.new

    expect(validator.concat_response_with_api_key(response)).to eq 'a cool response token'
  end

  it 'converts response to a hash' do
    response = 'response with token'
    validator = FyberOffersApiValidator.new

    expect(validator.response_hash(response)).to eq '0019aa986a0085b762e2e097e534afec4dfc0cd3'
  end

  it 'is valid' do
    response_token = '1234'
    validator = FyberOffersApiValidator.new
    allow(validator).to receive(:response_hash).and_return '1234'

    expect(validator.valid?(response_token)).to be_truthy
  end

  it 'is not valid' do
    response_token = '4321'
    validator = FyberOffersApiValidator.new
    allow(validator).to receive(:response_hash).and_return '1234'

    expect(validator.valid?(response_token)).to be_falsey
  end
end