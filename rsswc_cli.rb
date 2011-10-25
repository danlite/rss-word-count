require './lib/count'
require './lib/rss_parse'

rss_url = ARGV[0]

unless rss_url
  puts "You must provide the URL for an RSS feed."
  exit
end

rss_url = "http://#{rss_url}" unless rss_url =~ /^(https?)|(ftp):\/\//

urls = KikAss::RssParser.new(rss_url).get_article_links

counter = KikAss::WordCounter.new(urls)
counter.count_words

counter.top_words(50).each_with_index do |w, i|
  puts "%d\t%s\t%d" % [i + 1, w[:word].ljust(15), w[:count]]
end