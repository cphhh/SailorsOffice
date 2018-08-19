class InvoicesController < ApplicationController

  def new
    @invoice = Invoice.new
    @user = current_user
    @regatta_id = regatta_params.fetch(:regatta_id)

  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      flash[:success] = "Added new Invoice"
      render 'new'
    else
      flash[:danger] = "Invoice not saved. Please check parameters!"
      render 'new'
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @regatta = Regatta.find(@invoice.regatta_id)
    @user = User.find(@invoice.user_id)
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def index
    @invoices = Invoice.all
    @regattas = Regatta.all
    @user = User.all
  end

  def myinvoices
    @invoices = Invoice.where(:user_id => current_user.id)
  end

  private
    def invoice_params
      params.require(:invoice).permit(:name, :price, :comment, :user_id, :regatta_id)
    end

    def regatta_params
      params.permit(:regatta_id )
    end

end
