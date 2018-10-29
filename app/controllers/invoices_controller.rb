# Invoices Controller
class InvoicesController < ApplicationController
  def new
    @invoice = Invoice.new
    @user = current_user
    @regatta_id = regatta_params.fetch(:regatta_id)
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      flash[:success] = 'Added new Invoice'
    else
      flash[:danger] = 'Invoice not saved. Please check parameters!'
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

  def destroy
    Invoice.find(params[:id]).destroy
    flash[:success] = 'Invoice destroyed'
    redirect_to '/invoices'
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
