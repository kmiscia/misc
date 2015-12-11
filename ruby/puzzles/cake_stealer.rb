class CakeStealer

  def self.max_duffel_bag_value(cake_tuples, capacity)

    cake_tuples.sort_by! do |tuple|
      p "Tuple #{tuple} is worth #{tuple[1] / tuple[0]}/lb"
      tuple[1] / tuple[0]
    end
    cake_tuples.reverse!

    p "Sorted tuples = #{cake_tuples}"

    running_weight = 0
    running_profit = 0

    cake_tuples.each do |tuple|
      p "Processsing #{tuple}, running weight is #{running_weight}"

      cake_weight = tuple[0]
      cake_cost = tuple[1]

      while (running_weight + cake_weight) <= capacity do
        p "Adding #{cake_weight} b/c #{running_weight} + #{cake_weight} < #{capacity}"
        running_weight += cake_weight
        running_profit += cake_cost
      end
    end

    p "Final Weight = #{running_weight}"
    p "Final Profit = #{running_profit}"
  end

end

CakeStealer.max_duffel_bag_value([[12, 180], [6, 123], [4, 100]], 124)