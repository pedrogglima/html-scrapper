require './product_extracter'
require './product_collection'

urls = %w[https://lista.mercadolivre.com.br/celular-sony
          https://lista.mercadolivre.com.br/celular-samsung
          https://lista.mercadolivre.com.br/celular-apple
          https://lista.mercadolivre.com.br/celular-lg
          https://lista.mercadolivre.com.br/celular-windows]


collection = ProductCollection.new
collection = ProductExtracter.new(collection).extract(urls)

puts "================"
collection.each { |product| puts product }
puts "================"
puts collection.size
puts "================"

