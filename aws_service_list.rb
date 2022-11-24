require 'open-uri'
require 'json'

AWS_OFFER_PREFIX = 'https://pricing.us-east-1.amazonaws.com'.freeze
AWS_OFFER_INDEX_FILE = "#{AWS_OFFER_PREFIX}/offers/v1.0/aws/index.json".freeze
AWS_TOKYO_REGION_CODE = 'ap-northeast-1'.freeze

def remove_aws_amazon_prefix(name)
  name.to_s.sub(/^(AWS|Amazon)/, '')
end

def create_csv_url(base_url)
  AWS_OFFER_PREFIX + base_url.sub(/index.json$/, "#{AWS_TOKYO_REGION_CODE}/index.csv")
end

offer_index_json = JSON.parse(URI.parse(AWS_OFFER_INDEX_FILE).open.read, symbolize_names: true)

result = offer_index_json[:offers].keys.each_with_object({}) do |item, result|
  result[remove_aws_amazon_prefix(item)] = create_csv_url(offer_index_json[:offers][item][:currentVersionUrl])
end

p result
