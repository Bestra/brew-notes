class HopManifestsController < ApplicationController

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @manifests = @recipe.hop_manifests

    render json: @manifests
  end

  def show
    @manifest = HopManifest.find(params[:id])
    render json: @manifest
  end

  def create
    @hop_man = HopManifest.new(params[:hop_manifest])
    @recipe = @hop_man.recipe
    if @hop_man.save(params[:hop_manifest])
      respond_to do |format|
        format.html { redirect_to @recipe}
      end
    else
      redirect_to @recipes
    end
  end

  def update
    @h = HopManifest.find(params[:id])
    @recipe = @h.recipe
    if @h.update_attributes(params[:hop_manifest])
      respond_to do |format| 
        redirect_to @recipe
      end
    end
  end

  def destroy
    @h = HopManifest.find(params[:id])
    @recipe = @h.recipe
    @h.destroy
    respond_to do |format| 
      redirect_to @recipe
    end
  end
end
