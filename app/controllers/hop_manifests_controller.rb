class HopManifestsController < ApplicationController
  def create
    @hop_man = HopManifest.new(params[:hop_manifest])
    @recipe = @hop_man.recipe
    if @hop_man.save(params[:hop_manifest])
      redirect_to @recipe
    else
      redirect_to @recipes
    end
  end

  def update
    @h = HopManifest.find(params[:id])
    @recipe = @h.recipe
    if @h.update_attributes(params[:hop_manifest])
      
      redirect_to @recipe
    end
  end

  def destroy
    @h = HopManifest.find(params[:id])
    @recipe = @h.recipe
    @h.destroy
    redirect_to @recipe
  end
end
