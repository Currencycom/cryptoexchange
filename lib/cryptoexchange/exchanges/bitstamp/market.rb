module Cryptoexchange::Exchanges
  module Bitstamp
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitstamp'
      API_URL = 'https://www.bitstamp.net/api/v2'
    end
  end
end
