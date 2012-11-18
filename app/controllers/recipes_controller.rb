class RecipesController < ApplicationController
  before_filter :update_recipe_og, :only => :show
  def new
  end

  def create
  end

  def edit
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      respond_to do |format|
       # format.html {redirect_to @recipe, :notice =>"Successfully updated"}
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @new_hop = @recipe.hop_manifests.build
    @new_ferm = @recipe.fermentable_manifests.build

    respond_to do |format|
      format.html
      format.json {render json: @recipe}
    end
  end

  def index
    @recipes = Recipe.all
  end

  def destroy
  end
  private
    def update_recipe_og
      @recipe = Recipe.find(params[:id])
      total_points = 0
      @recipe.fermentable_manifests.each do |ferm|
        ferm_points = ferm.amount * ferm.fermentable.ppg / 16 
        total_points = total_points + ferm_points
      end
      new_og = total_points / (1000 * @recipe.final_volume) + 1
      new_og = new_og.round(3)
      @recipe.og = new_og
      @recipe.save
    end
end
