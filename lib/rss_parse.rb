require 'nokogiri'
require 'open-uri'

module KikAss
  class RssParser
    
    def initialize(rss_url)
      @rss_url = rss_url
    end
    
    def get_article_links
      rss_xml = Nokogiri::XML(open(@rss_url))
      rss_xml.css('rss item link').map{|node| node.text}
    end
    
  end
end