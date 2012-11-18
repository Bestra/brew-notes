class HopsController < ApplicationController
  def index
    @hops = Hop.all
  end

  def show
    @hop = Hop.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @hop}
    end
  end

  def new
    @hop = Hop.new
  end

  def create
    @hop = Hop.new(params[:hop])

    if @hop.save
      redirect_to hops_path
    end
  end

  def edit
    @hop = Hop.find(params[:id])
  end

  def update
    @hop = Hop.find(params[:id])
    if @hop.update_attributes(params[:hop])
      redirect_to hops_path
    else
      render 'edit'
    end
  end

  def destroy
    @hop = Hop.find(params[:id]).destroy
    redirect_to hops_path
  end
end
