require 'digest/sha1'

class FyberOffersApiValidator
  attr_reader :response

  MY_API_KEY = FyberOffersApiToken::MY_API_KEY

  def initialize(response = '')
    @response = response
    @hash = ''
  end

  def valid?(response_token)
    response_hash(@response) == response_token
  end

  def response_hash(response)
    response = concat_with_api_key(response)
    @hash = sha1(response)
  end

  def concat_with_api_key(response)
    [response, MY_API_KEY].join('')
  end

  private

  def sha1(token)
    Digest::SHA1.hexdigest(token)
  end
end