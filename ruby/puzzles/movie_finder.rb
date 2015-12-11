class MovieFinder
  def self.find(flight_length, movie_lengths)
    movie_lengths.each_with_index do |length_one, index_one|
      movie_lengths.each_with_index do |length_two, index_two|
        p true and return if (length_two + length_one == flight_length) && index_one != index_two
      end
    end
    p false
  end
end