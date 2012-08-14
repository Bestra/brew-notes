class HopsController < ApplicationController
  def index
    @hops = Hop.all
  end

  def show
  end

  def new
  end
end
