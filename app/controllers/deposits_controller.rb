class DepositsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :index, :edit, :update, :destroy]

  def new
		@deposit = Deposit.new
    @user = current_user
  end

	def create
		@deposit = Deposit.new(deposit_params)
		if @deposit.save
			flash[:success] = 'Added new deposit'
			redirect_to '/deposits'
		else
			flash[:danger] = 'Deposit not saved. Please check parameters!'
			redirect_to '/deposits/new'
		end
	end

  def index
		@deposits = Deposit.all.order(date: :desc)
    @user = current_user
		@users = User.all
  end

	def edit
    @deposit = Deposit.find(params[:id])
		@user_id = User.all.find(@deposit.user_id).id
  end

  def update
    @deposit = Deposit.find(params[:id])
    @deposit.update(deposit_params)
    redirect_to deposits_path
  end

	def destroy
    Deposit.find(params[:id]).destroy
    flash[:success] = 'Deposit destroyed'
    redirect_to '/deposits'
  end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def deposit_params
		params.require(:deposit).permit(
			:user_id, :amount, :date
		)
	end
end
