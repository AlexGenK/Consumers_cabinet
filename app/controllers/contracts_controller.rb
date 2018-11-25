class ContractsController < ApplicationController
  before_action :set_contract, only: [:destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :edit, :update]
  load_and_authorize_resource

  def create
    @contract = @consumer.contracts.new(contract_params)
    flash[:alert] = 'Невозможно создать договор' unless @contract.save
    redirect_to @consumer
  end

  def destroy
    flash[:alert] = 'Невозможно удалить догвор' unless @contract.destroy
    redirect_to @consumer
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def set_consumer
    @consumer = Consumer.find(params[:consumer_id])
  end

  def contract_params
    params.require(:contract).permit(:number, :date)
  end

end
