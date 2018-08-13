class RegattasController < ApplicationController

  def show
    @regatta = Regatta.find(params[:id])
  end

  def index
    @regattas = Regatta.all
  end

  def new
    @regatta = Regatta.new
  end

  def create
    @regatta = Regatta.new(regatta_params)
    if @regatta.save
      flash[:success] = "Added new regatta"
      redirect_to @regatta
    else
      flash[:dange] = "Regatta not saved. Please check parameters!"
      render 'new'
    end
  end

  def edit
    @regatta = Regatta.find(params[:id])
  end

  def update
      @regatta = Regatta.find(params[:id])
      @regatta.update(regatta_params)
      redirect_to regattas_path
  end

  def regatta_params
    params.require(:regatta).permit(:name, :place, :startdate, :enddate)
  end

  def destroy
    Regatta.find(params[:id]).destroy
    flash[:success] = "Regatta destroyed"
    redirect_to '/regattas'
  end


end
