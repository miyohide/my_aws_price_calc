require 'open-uri'

URI.open("https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json") do |f|
  f.each_line { |line| p line }
end
