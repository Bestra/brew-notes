class FermentableManifestsController < ApplicationController

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @manifests = @recipe.fermentable_manifests

    render json: @manifests
  end
  def show
    @fm = FermentableManifest.find(params[:id])
    render json: @fm 
  end
  def create
    @fm = FermentableManifest.new(params[:fermentable_manifest])
    @recipe = @fm.recipe
    if @fm.save
      respond_to do |format|
        format.html {render json: @fm}
        format.json { render json: @fm }
      end
    else 
      redirect_to @recipes
    end
  end

  def update
    @fm = FermentableManifest.find(params[:id])
    @recipe = @fm.recipe
    if @fm.update_attributes(params[:fermentable_manifest])
      respond_to do |format|
        format.html {redirect_to @recipe}
      end
    end
      
  end

  def destroy
    @fm = FermentableManifest.find(params[:id])
    @recipe = @fm.recipe
    @fm.destroy
    respond_to do |format|
      format.html {redirect_to @recipe}
    end
  end
end
