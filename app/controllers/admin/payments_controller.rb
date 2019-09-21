class Admin::PaymentsController < ApplicationController
  before_action :set_payment
  load_and_authorize_resource

  def edit
  end

  def update
    if @payment.update(payment_params)
      flash[:notice] = "Платежные реквизиты отредактированы" 
      redirect_to consumers_path
    else
      render :edit
    end
  end

  private

  def set_payment
    @payment = Payment.first
  end

  def payment_params
    params.require(:payment).permit(:company, :edrpou, :account, :bank, :mfo)
  end
end
