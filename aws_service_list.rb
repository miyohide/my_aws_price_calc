require 'open-uri'
require 'json'

AWS_OFFER_INDEX_FILE = 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json'.freeze

def remove_aws_amazon_prefix(name)
  name.to_s.sub(/^(AWS|Amazon)/, '')
end

offer_index_json = JSON.parse(URI.parse(AWS_OFFER_INDEX_FILE).open.read, symbolize_names: true)

offered_list = offer_index_json[:offers].keys.map do |offer_name|
  remove_aws_amazon_prefix(offer_name)
end

p offered_list.sort
