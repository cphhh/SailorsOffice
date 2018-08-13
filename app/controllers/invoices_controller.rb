class InvoicesController < ApplicationController

  def new
    @invoice = Invoices.new
  end

  def create
    @invoice = Invoices.new(invoice_params)
    if @invoice.save
      flash[:success] = "Added new Invoice"
      redirect_to @invoice
    else
      flash[:dange] = "Invoice not saved. Please check parameters!"
      render 'new'
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def index
    @regattas = Regatta.all
  end

  private
    def regatta_params
      params.require(:invoice).permit(:name, :price, :comment, :user_id, :regatta_id)
    end
  end
end
