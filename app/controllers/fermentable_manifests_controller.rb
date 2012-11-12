class FermentableManifestsController < ApplicationController
  def new
  end

  def create
    @fm = FermentableManifest.new(params[:fermentable_manifest])
    @recipe = @fm.recipe
    if @fm.save(params[:fermentable_manifest])
      redirect_to @recipe
    else 
      redirect_to @recipes
    end
  end

  def update
    @fm = FermentableManifest.find(params[:id])
    @recipe = @fm.recipe
    if @fm.update_attributes(params[:fermentable_manifest])
      
      redirect_to @recipe
    end
      
  end

  def destroy
    @fm = FermentableManifest.find(params[:id])
    @recipe = @fm.recipe
    @fm.destroy
    redirect_to @recipe
  end
end
