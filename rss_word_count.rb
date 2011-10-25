require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'

require './lib/count'
require './lib/rss_parse'

before '/count*' do
  @rss_url = params[:rss_url]
  redirect '/' if @rss_url.to_s.empty?
end

get '/' do
  haml :index
end

post '/count' do
  start_time = Time.now
  
  top_words = get_top_words(@rss_url)
  
  results = "<p>Source: #{@rss_url}</p><pre>\n"
  
  top_words.each_with_index do |w, i|
    results << "%d\t%d\t%s\n" % [i + 1, w[:count], w[:word]]
  end
  
  time_diff = Time.now - start_time
  
  results += "</pre><p>Time: #{time_diff}</p>"
  
  haml results
end

post '/count.json' do
  content_type :json
  results = []
  
  top_words = get_top_words(@rss_url)
  
  top_words.each_with_index do |w, i|
    results << {:i => i + 1, :w => w[:word], :c => w[:count]}
  end
  
  results.to_json
end

# helper methods

def get_top_words(rss_url)
  urls = KikAss::RssParser.new(rss_url).get_article_links
  
  counter = KikAss::WordCounter.new(urls)
  counter.count_words
  
  counter.top_words(50)  
end