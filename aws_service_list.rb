require 'open-uri'
require 'json'
require 'net/http'

AWS_OFFER_PREFIX = 'https://pricing.us-east-1.amazonaws.com'.freeze
AWS_OFFER_INDEX_FILE = "#{AWS_OFFER_PREFIX}/offers/v1.0/aws/index.json".freeze
AWS_TOKYO_REGION_CODE = 'ap-northeast-1'.freeze

def remove_aws_amazon_prefix(name)
  name.to_s.sub(/^(AWS|Amazon)/, '')
end

def create_csv_url(base_url)
  AWS_OFFER_PREFIX + base_url.sub(/index.json$/, "#{AWS_TOKYO_REGION_CODE}/index.csv")
end

def create_service_csv(url, csv_file_name)
  u = URI.parse(url)
  http = Net::HTTP.new(u.host, u.port)
  http.use_ssl = true
  File.open(csv_file_name, 'w') do |f|
    http.request_get(u.path) do |response|
      response.read_body do |s|
        f.write(s)
      end
    end
  end
end

offer_index_json = JSON.parse(URI.parse(AWS_OFFER_INDEX_FILE).open.read, symbolize_names: true)

result = offer_index_json[:offers].keys.each_with_object({}) do |item, memo_obj|
  memo_obj[remove_aws_amazon_prefix(item)] = create_csv_url(offer_index_json[:offers][item][:currentVersionUrl])
end

['EC2', 'S3'].each do |s|
  create_service_csv(result[s], s + '.csv')
end

# uri = URI.parse(result['EC2'])
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# File.open('EC2.csv', 'w') do |f|
#   http.request_get(uri.path) do |response|
#     response.read_body do |s|
#       f.write(s)
#     end
#   end
# end
#
# uri = URI.parse(result['S3'])
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# File.open('S3.csv', 'w') do |f|
#   http.request_get(uri.path) do |response|
#     response.read_body do |s|
#       f.write(s)
#     end
#   end
# end
