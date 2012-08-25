class RecipesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @recipe = Recipe.find(params[:id])
    @new_hop = @recipe.hop_manifests.build
    @new_ferm = @recipe.fermentable_manifests.build
  end

  def index
  end

  def destroy
  end
end
