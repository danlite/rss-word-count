### Instructions

`$ gem install bundler`

`$ bundle install`

`$ ruby -rubygems rss_word_count.rb`

### Caveats

Developing on Mac OS X, I found it necessary to install Nokogiri using the homebrew instructions on the [Nokogiri website](http://nokogiri.org/tutorials/installing_nokogiri.html) (using libxml version 2.7.8 instead of 2.7.7).

### Libraries

- OpenURI for fetching RSS feed and articles
- Nokogiri for parsing RSS feed
- Port of [Readability](http://code.google.com/p/arc90labs-readability/) to extract article content from the HTML 

### Assumptions and Limitations

Parses only RSS feeds (support for Atom feeds would require slight modifications to `rss_parse.rb`).

Counts words found in the main content sections of the linked article, rather than all text on the page (e.g. navigation, advertisements, headers and footers, etc.).

Will only parse first page of a paginated article (a feature missing from the Ruby port of Readability).