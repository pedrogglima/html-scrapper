require './parser'
require './logger'

class ProductExtracter
  include Parser

  attr :collection

  def initialize(collection)
    @collection = collection
  end

  def extract(urls)
    parsers = Parser.parser_urls(urls)
    parsers.to_a.each { |html| extract_html(html) }
    collection
  end

  private
  def extract_html(html)
    ol = html.at_css("ol#searchResults") # List of itens to be searched

    if ol
      ol.children.each do |li| # Extract text from the list ~ array of arrays
        collection << li.text.downcase.split(/\s{2,}/) unless li.text.size == 1 # remove Nokogiri::Element::Text: " "
      end
      Logger.info("Page extracted")
    else
      Logger.error("Error extracting")
    end
  end
end
