require 'open-uri'
require 'readability'

module KikAss
  class WordCounter
    attr_reader :word_count
    
    def initialize(urls = [])
      reset_word_count
      @urls = urls
    end
      
    def count_words
      @urls.each do |url|
        text = get_plain_text(url)
        count_page_words(text) if text
      end
    end
    
    def top_words(amount)
      @word_count.values.sort{|a,b| b[:count] <=> a[:count]}[0, amount]
    end
    
    protected

    def get_plain_text(url)
      begin
        source = open(url).read
      rescue Exception => e
        puts "Error reading #{url}: #{e.message}"
        return nil
      end
      
      text = nil
      begin
        doc = Nokogiri::HTML(Readability::Document.new(source).content)
        text = doc.text
      rescue Exception => e
        puts "Error parsing #{url}: #{e.message}"
      end
      
      text
    end

    def count_page_words(plain_text)
      matches = plain_text.scan(/\b(\w+('\w+)?)\b/)
      matches.each do |match|
        word = match[0].downcase
        @word_count[word][:count] += 1
      end
    end
    
    def reset_word_count
      @word_count = Hash.new{|h,k| h[k] = {:word => k, :count => 0}}
    end
    
  end
end
