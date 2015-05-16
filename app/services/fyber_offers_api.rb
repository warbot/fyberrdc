require 'rest-client'

class FyberOffersApi
  attr_reader :client, :response_token

  def initialize
    @client = RestClient
    @tokenizer = FyberOffersApiToken
    @validator = FyberOffersApiValidator
    @response = {headers: {}}
  end

  def offers
    @response = client.get(url, params: params)
  end

  def response_valid?(response)
    @validator.new(response).valid?(response_token)
  end

  def response_token
    @response.headers[:x_sponsorpay_response_signature]
  end

  private

  def uri
    'http://api.sponsorpay.com'
  end

  def offer_path
    '/feed/v1/offers.json'
  end

  def url
    uri.concat(offer_path)
  end

  def request_current_time
    Time.current.to_i
  end

  def static_params
    {
        appid: 157,
        device_id: '2b6f0cc904d137be2e1730235f5664094b83',
        locale: 'de',
        os_version: '8',
        ip: '109.235.143.113',
        offer_types: 112,
        timestamp: request_current_time,
        apple_idfa: '2E7CE4B3-F68A-44D9-A923-F4E48D92B31E',
        apple_idfa_tracking_enabled: false
    }
  end

  def user_params
    {
        uid: 157,
        pub0: 'campaign2',
        page: 1
    }
  end

  def params_without_hashkey
    user_params.merge(static_params)
  end

  def params
    params_without_hashkey.merge(hashkey: hashkey)
  end

  def hashkey
    @tokenizer.new(params_without_hashkey).token
  end

end