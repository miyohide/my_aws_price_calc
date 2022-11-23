require 'open-uri'
require 'json'

AWS_OFFER_INDEX_FILE = "https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json"

offer_index_json = JSON.parse(URI.open(AWS_OFFER_INDEX_FILE).read, symbolize_names: true)

p offer_index_json
