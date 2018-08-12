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

  def regatta_params
    params.require(:regatta).permit(:name, :place, :startdate, :enddate)
  end
end
