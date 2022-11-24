require 'open-uri'
require 'json'

AWS_OFFER_PREFIX = 'https://pricing.us-east-1.amazonaws.com'.freeze
AWS_OFFER_INDEX_FILE = "#{AWS_OFFER_PREFIX}/offers/v1.0/aws/index.json".freeze

def remove_aws_amazon_prefix(name)
  name.to_s.sub(/^(AWS|Amazon)/, '')
end

offer_index_json = JSON.parse(URI.parse(AWS_OFFER_INDEX_FILE).open.read, symbolize_names: true)

result = offer_index_json[:offers].keys.each_with_object({}) do |item, result|
  result[remove_aws_amazon_prefix(item)] = offer_index_json[:offers][item][:currentVersionUrl]
end

p result
