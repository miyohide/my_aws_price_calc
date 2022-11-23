require 'open-uri'

AWS_OFFER_INDEX_FILE = "https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json"

URI.open(AWS_OFFER_INDEX_FILE) do |f|
  f.each_line { |line| p line }
end
