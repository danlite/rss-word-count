## Instructions

#### Sinatra App

    $ gem install bundler
    $ bundle install
    $ ruby -rubygems rss_word_count.rb

#### Command-line

    $ gem install bundler
    $ bundle install
    $ ruby rsswc_cli.rb "http://rss.cbc.ca/lineup/topstories.xml"


## Caveats

Developing on Mac OS X, I found it necessary to install Nokogiri using the homebrew instructions on the [Nokogiri website](http://nokogiri.org/tutorials/installing_nokogiri.html) (using libxml version 2.7.8 instead of 2.7.7).

## Libraries

- OpenURI for fetching RSS feed and articles
- Nokogiri for parsing RSS feed
- Port of [Readability](http://code.google.com/p/arc90labs-readability/) to extract article content from the HTML 

## Assumptions and Limitations

Parses only RSS feeds (support for Atom feeds would require slight modifications to `rss_parse.rb`). Does not attempt to validate RSS.

Counts words found in the main content sections of the linked article, rather than all text on the page (e.g. navigation, advertisements, headers and footers, etc.).

Will only parse first page of a paginated article (a feature missing from the Ruby port of Readability).

For large feeds and articles, parsing may take a long time (~60 seconds). This may cause the app running on Heroku to time out. To scale performance, parsing should be added to a queue to be performed in a background worker. Per-article word counts could be cached for better performance on subsequent requests.
