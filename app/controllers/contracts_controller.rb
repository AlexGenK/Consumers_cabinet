class ContractsController < ApplicationController
  before_action :set_contract, only: [:destroy, :show]
  before_action :set_consumer, only: [:create, :destroy, :show]
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

  def show
    @prev_consumptions = @consumer.previous_consumptions.all.order('date DESC')
    @plan_consumption = @consumer.current_consumption
    @counters = @contract.counters.all.order(:number)
    @counters_power={}
    @all_power_active, @all_power_reactive, @all_power_generation = 0, 0, 0
    @counters.each do |item|
      power = item.powers.where("measure_date >= ? AND measure_date <= ?",
                                DateTime.now.beginning_of_month.to_date,
                                DateTime.now.end_of_month.to_date).last
      power ||= item.powers.new(measure_date: DateTime.now)
      @all_power_active += power.active_result * item.ratio
      @all_power_reactive += power.reactive_result * item.ratio
      @all_power_generation += power.generation_result * item.ratio
      @counters_power[item.id] = power
    end
    @counter = @contract.counters.new
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
