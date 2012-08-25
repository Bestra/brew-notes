class FermentablesController < ApplicationController
  def index
    @fermentables = Fermentable.all
  end

  def show
  end

  def edit
    @fermentable = Fermentable.find(params[:id])
  end

  def update
    @fermentable = Fermentable.find(params[:id])
    if @fermentable.update_attributes(params[:fermentable])
      redirect_to fermentables_path
    else
      render 'edit'
    end
  end
  def destroy
    Fermentable.find(params[:id]).destroy
    redirect_to fermentables_path
  end

  def new
    @fermentable = Fermentable.new
  end

  def create
    @fermentable = Fermentable.new(params[:fermentable])
    if @fermentable.save
      redirect_to fermentables_path
    else
      render 'new'
    end
  end
end
