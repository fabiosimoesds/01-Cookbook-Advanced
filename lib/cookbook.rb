require_relative 'controller'
require_relative 'recipe'
require "csv"

class Cookbook
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_data
  end

  def all
    @recipes
  end

  def load_data
    CSV.foreach(@csv_file) do |row|
      unless row.empty?
        loaded_recipe = Recipe.new(row[0], row[1], row[2], row[3], row[4])
        add_recipe(loaded_recipe)
      end
    end
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_data
    # adds a new recipe - get the information from recipe.rb
  end

  def save_data
    CSV.open(@csv_file, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_data
    # get the index from the view
    # delete a new recipe using the index from the repository
  end
end
