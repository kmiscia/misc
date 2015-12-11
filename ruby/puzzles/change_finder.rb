class ChangeFinder

  def initialize(denoms)
    @denoms = denoms
    @combinations = []
  end

  def for(amount)
    find([], amount)
    p @combinations
  end

  def find(combos, amount)
    @denoms.each do |denom|
      next if denom > amount
      if denom == amount
        @combinations << combos + [denom]
      else
        find(combos + [denom], amount - denom)
      end
    end

    @combinations.collect!{ |combination| combination.sort }
    @combinations.uniq!
  end

end

ChangeFinder.new([25, 10, 5, 1]).for(26)