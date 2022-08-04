require_relative 'recipe'
require_relative 'view'
require_relative 'cookbook'
require_relative 'parsing'

class Controller
  def initialize(repository)
    @cookbook = repository
    @view = View.new
  end

  def create
    # asking the user what is the name of the recipe
    name = @view.ask_for("What is the name of the recipe?")
    # asking the user what is the description of the recipe
    description = @view.ask_for("What is the description?")
    # asking for the rating
    rating = @view.ask_for("What is the rating for this recipe? [0-5]")
    # asking for the prep time
    prep_time = @view.ask_for("What is the prep time of this recipe? [min]")
    # creating a new recipe
    new_recipe = Recipe.new(name, description, rating, prep_time)
    # add the recipe to the data base
    @cookbook.add_recipe(new_recipe)
    list
  end

  def destroy
    list
    index = @view.ask_for("Which of the recipes would you like to delete? [Number]").to_i - 1
    @cookbook.remove_recipe(index)
    list
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
    # get the respository and send it to view and get a nice list back
  end

  def import
    keyword = @view.ask_keyword
    # search for the keyword on parsing
    # get the top 5 recipes suggested in an array
    my_scrapping = Scrapping.new(keyword)
    top_five = my_scrapping.scrape_recipes
    # sent the array to view and display them nicely with an index
    @view.display_search(top_five)
    # ask the user on view which is the index he wants to import
    index = @view.ask_for("Which of the recipes would you like to add to your cookbook? [Number]").to_i - 1
    # after the user feedback add the recipe to the cookbook
    new_recipe = Recipe.new(top_five[index][0], top_five[index][1], top_five[index][2], top_five[index][3])
    # add the recipe to the data base
    @cookbook.add_recipe(new_recipe)
    list
  end

  def mark_as_done
    list
    index = @view.ask_for("Which recipe would you like to mark as done? [Number]").to_i - 1
    @cookbook.all[index].done = @cookbook.all[index].done!
    @cookbook.save_data
    list
  end
end

#<Cookbook:0x00007f2ed8eedc58 @recipes=[#<Recipe:0x00007f2ed8ef1b28 @name="chocolate", @description="cake", @done=false>, #<Recipe:0x00007f2ed8ef04a8 @name="carrot", @description="cake", @done=false>, #<Recipe:0x00007f2ed8ef78e8 @name="Strawberry Delight", @description="A delightful strawberry dessert that is sure to be eaten quickly.", @done=false>]
