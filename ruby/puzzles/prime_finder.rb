class PrimeFinder

  def initialize(val)
    @value = val
  end

  def primes
    (1..@value).each do |index|
      p index if prime?(index)
    end
  end

  def prime?(x)
    (2..x - 1). do |y|
      return false if x % y == 0
    end
    return true
  end

end

PrimeFinder.new(50).primes