# BalancesController
class BalancesController < ApplicationController
  def new
    @balance = Balance.new
  end

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      flash[:success] = 'Added new balance'
    else
      flash[:dange] = 'Balance not saved. Please check parameters!'
      render 'new'
    end
  end

  def show
    @balance = Balance.find(params[:id])
    @users = @balance.regatta.users.all
    @costs = @balance.regatta.invoices.all.sum(:price)
    @supplement = ((@costs/@users.count)/100)*5
    @fee = ((@balance.regatta.enddate - @balance.regatta.startdate).to_i + 1)*5
    @totalcosts = (@costs / @users.count) + @supplement + @fee
    @totalprofit = (@users.count*@supplement) + (@users.count*@fee)
  end

  def edit; end

  def index
    @balances = Balance.all
  end

  def balance_params
    params.require(:balance).permit(:regatta_id, :closed, :closed_date)
  end
end
