class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :done

  def initialize(name, description, rating, prep_time, done = false)
    @name = name
    @description = description
    @done = done
    @rating = rating
    @prep_time = prep_time
  end

  def done!
    @done = true
  end
end
