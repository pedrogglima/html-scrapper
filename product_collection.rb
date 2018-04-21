
class ProductCollection
  attr :products

  def initialize
    @products = Array.new
  end

  def << (other)
    new_instance = self.class.new
    new_instance.replace!(products.<<(other))
    new_instance
  end

  alias_method :add, :<<
  alias_method :push, :<<

  def delete(product) # return the deleted element, not the instance class
    products.delete(product)
  end

  alias_method :remove, :delete
  alias_method :pop, :delete

  def size
    products.size
  end

  alias_method :length, :size

  def each(&block)
    new_instance = self.class.new
    new_instance.replace!(products.each(&block))
    new_instance
  end

  protected
    def replace!(products)
      @products = products
    end
end
