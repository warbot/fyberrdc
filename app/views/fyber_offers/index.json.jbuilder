json.array!(@fyber_offers) do |fyber_offer|
  json.extract! fyber_offer, :id
  json.url fyber_offer_url(fyber_offer, format: :json)
end
