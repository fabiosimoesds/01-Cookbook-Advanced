class View
  def ask_for(question)
    puts question.to_s
    gets.chomp
  end

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      recipe.done == true || recipe.done == "true" ? mark = "[X]" : mark = "[ ]"
      puts "#{index + 1}. #{mark} - #{recipe.name}: #{recipe.description} (#{recipe.rating} / 5)"
      puts "======PREP-TIME #{recipe.prep_time}======"
      puts "-" * 40
    end
  end

  def display_search(recipes_internet)
    recipes_internet.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe[0]} - #{recipe[1]} (#{recipe[2]} / 5)"
      puts "======PREP-TIME #{recipe[3]}======"
      puts "-" * 40
    end
  end

  def ask_keyword
    puts "What ingredient would you like a recipe for?"
    keyword = gets.chomp
    puts "Looking for #{keyword} recipes on the Internet..."
    return keyword
  end
end
