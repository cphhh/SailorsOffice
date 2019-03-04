# Invoices Controller
class InvoicesController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :index, :myinvoices,
                                        :destroy, :new, :create, :update,
                                        :regattainvoices]

  def new
    @invoice = Invoice.new
    @user = current_user
		@users = User.all
    @regatta_id = regatta_params.fetch(:regatta_id)
  end

  def create
    regatta = Regatta.find(invoice_params.fetch(:regatta_id))
    regatta_id = invoice_params.fetch(:regatta_id)

    if regatta.balance[:closed] == true
      @invoice = Invoice.new(invoice_params)
      flash[:danger] = "Die Abrechnung für die #{regatta[:name]} Regatta wurde" \
                       " bereits am #{regatta.balance[:closing_date]} geschlossen." \
                       " Rechnung wurde nicht eingereicht."
    elsif regatta.balance[:closed] == false
      @invoice = Invoice.new(invoice_params)
      if @invoice.save
        flash[:success] = 'Added new Invoice'
      else
        flash[:danger] = 'Invoice not saved. Please check parameters!'
      end
    end
    render 'new'
  end

  def show
    @invoice = Invoice.find(params[:id])
    @regatta = Regatta.find(@invoice.regatta_id)
    @user = User.find(@invoice.user_id)
  end

  def edit
    @invoice = Invoice.find(params[:id])
		todayminus = Date.today - 200
		todayplus = Date.today + 200
		valid_regattas = Regatta.joins(:balance).where('balances.closed == ?', false)
		@regattas = valid_regattas.order(startdate: :asc).where('startdate > ? AND startdate < ?', todayminus, todayplus)
		@regatta_id = Regatta.all.find(@invoice.regatta_id).id
		@user_id = User.all.find(@invoice.user_id).id
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(invoice_params)
    redirect_to invoices_path
  end

  def index
    @invoices = Invoice.all
    @regattas = Regatta.all
    @user = User.all
  end

  def myinvoices
    @invoices = Invoice.where(user_id: current_user.id)
  end

  def regattainvoices
    @regatta = Regatta.find(regatta_params.fetch(:regatta_id))
    @invoices = Invoice.where(regatta_id: regatta_params.fetch(:regatta_id))
  end

  def destroy
    Invoice.find(params[:id]).destroy
    flash[:success] = 'Invoice destroyed'
    redirect_to '/invoices'
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :name, :price, :comment, :user_id, :regatta_id
    )
  end

  def regatta_params
    params.permit(:regatta_id)
  end
end
