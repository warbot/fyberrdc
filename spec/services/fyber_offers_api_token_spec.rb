require 'rails_helper'

describe FyberOffersApiToken do
  it 'sorts the params alphabetical asc by keys' do
    params = {b: 2, c: 3, a: 1}
    tokenizer = FyberOffersApiToken.new(params)

    expect(tokenizer.params).to eq(a: 1, b: 2 , c:3)
  end

  it 'concatenates all params with &' do
    params = {b: 2, c: 3, a: 1}
    tokenizer = FyberOffersApiToken.new(params)

    expect(tokenizer.stringify_params).to eq 'a=1&b=2&c=3'
  end

  it 'concatenates params with api key' do
    tokenizer = FyberOffersApiToken.new
    params = 'a=1'

    expect(tokenizer.concat_with_api_key(params)).to eq 'a=1&b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
  end

  it 'generates SHA1' do
    params = {b: 2, c: 3, a: 1}
    tokenizer = FyberOffersApiToken.new(params)

    expect(tokenizer.token).to eq 'e4109ba2f8c759fa65fc244dde533d7cec4433e6'
  end
end