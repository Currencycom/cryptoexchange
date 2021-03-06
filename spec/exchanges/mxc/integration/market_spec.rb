require 'spec_helper'

RSpec.describe 'MXC integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'mxc' }
  let(:ont_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ONT', target: 'USDT', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: ont_usdt_pair.base, target: ont_usdt_pair.target
    expect(trade_page_url).to eq "https://www.mxc.com/trade.html?symbol=ONT_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ont_usdt_pair)

    expect(ticker.base).to eq ont_usdt_pair.base
    expect(ticker.target).to eq ont_usdt_pair.target
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(ont_usdt_pair)

    expect(order_book.base).to eq ont_usdt_pair.base
    expect(order_book.target).to eq ont_usdt_pair.target
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
