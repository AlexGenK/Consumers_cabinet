class Admin::PaymentsController < ApplicationController
  before_action :set_payment
  load_and_authorize_resource

  def edit
  end

  def update
  end

  private

  def set_payment
    @payment = Payment.find(1)
  end

  def user_params
    params.require(:payment).permit(:company, :edrpou, :acccount, :bank, :mfo)
  end
end
