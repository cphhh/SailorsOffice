# BalancesController
class BalancesController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :index, :new, :create]

  def new
    @balance = Balance.new
  end

  def create
    @balance = Balance.new(balance_params)
    if @balance.save
      flash[:success] = 'Added new balance'
    else
      flash[:danger] = 'Balance not saved. Please check parameters!'
      render 'new'
    end
  end

  def show
    @regatta = Balance.find(params[:id]).regatta
    @invoices = @regatta.invoices
    @users = @regatta.users.all
    @costs = @invoices.all.sum(:price)
    @supplement = (((@costs/@users.count)/100)*5).round(2)
    @fee = ((@regatta.enddate - @regatta.startdate).to_i + 1)*5
    @totalcosts = ((@costs / @users.count) + @supplement + @fee)
    @totalprofit = (@users.count*@supplement) + (@users.count*@fee)
  end

  def edit; end

  def index
    @balances = Balance.all
  end

  def balance_params
    params.require(:balance).permit(:regatta_id, :closed, :closed_date)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
