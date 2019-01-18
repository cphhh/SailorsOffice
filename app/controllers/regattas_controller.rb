# Regattas controller
class RegattasController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :index, :myinvoices,
                                        :destroy, :new, :create, :update,
                                        :joinregattas, :myregattas]

  def show
    @regatta = Regatta.find(params[:id])
  end

  def index
    @regattas = Regatta.all.order(startdate: :asc)
  end

  def new
    @regatta = Regatta.new
  end

  def create
    @regatta = Regatta.new(regatta_params)

		if @regatta.fee.blank?
			@regatta.fee = "5,00"
		end

		if @regatta.supplement.blank?
			@regatta.supplement = "5,00"
		end

    if @regatta.save
      flash[:success] = 'Added new regatta'
      Balance.create(regatta_id: @regatta.id, closed: false)
      redirect_to @regatta
    else
      flash[:danger] = 'Regatta not saved. Please check parameters!'
      render 'new'
    end
  end

  def edit
    @regatta = Regatta.find(params[:id])
  end

  def update
    @regatta = Regatta.find(params[:id])
    @regatta.update(regatta_params)
    redirect_to '/joinregattas'
  end

  def joinregattas
    @user = User.find(current_user.id)
    @users = User.all
    @regattas = Regatta.all.order(startdate: :asc)
  end

  def myregattas
    @regattas = current_user.regattas.all
  end

  def destroy
    Balance.where(regatta_id: params[:id]).take.destroy
    Regatta.find(params[:id]).destroy
    flash[:success] = 'Regatta destroyed'
    redirect_to '/regattas'
  end

  private

  def regatta_params
    params.require(:regatta).permit(
      :name, :place, :startdate, :enddate, :supplement, :fee, user_ids: []
    )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
