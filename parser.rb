require "nokogiri"
require "open-uri"
require 'thread'
require './logger'

module Parser
  @queue = Queue.new

  def self.parser_urls(urls)
    parsers = Array.new

    tprodutor = Thread.new do
      urls.to_a.each do |url|
        @queue.push(html(url))
      end
    end

    tconsumer = Thread.new do
      urls.to_a.size.times do
        doc = @queue.pop
        parsers << parse(doc) if doc
      end
    end

    tprodutor.join
    tconsumer.join
    parsers
  end

  def self.html(url)
    begin
      Logger.level = Logger::INFO
      Logger.info("Opening URL: #{url}")
      open(url)
    rescue Errno::ENOENT => e
      Logger.error("Failed to open url: #{url}")
      nil
    rescue SocketError => e
      Logger.error("Failed to open url: #{url}")
      nil
    end
  end

  def self.parse(html)
    Nokogiri::HTML(html)
  end

  private_class_method :html, :parse
end
