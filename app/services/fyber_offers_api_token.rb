require 'digest/sha1'

class FyberOffersApiToken
  attr_reader :params
  MY_API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

  def initialize(params = {})
    @params = params.sort.to_h
    @token = ''
  end

  def token
    @token = stringify_params
    @token = concat_with_api_key(@token)
    @token = sha1(@token)
  end

  def stringify_params
    @params.to_query
  end

  def concat_with_api_key(token)
    [token, MY_API_KEY].join('&')
  end

  private

  def sha1(token)
    Digest::SHA1.hexdigest(token)
  end
end