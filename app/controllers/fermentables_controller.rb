class FermentablesController < ApplicationController
  def index
    @fermentables = Fermentable.all
  end

  def show
  end

  def new
  end
end
