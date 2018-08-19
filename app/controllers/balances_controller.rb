class BalancesController < ApplicationController
  def new
    @balance = Balance.new
  end

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      flash[:success] = "Added new balance"
    else
      flash[:dange] = "Balance not saved. Please check parameters!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def index
  end

  def balance_params
    params.require(:balance).permit(:regatta_id, :closed, :closed_date)
  end
end
