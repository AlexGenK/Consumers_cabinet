class ContractsController < ApplicationController
  before_action :set_contract, only: [:destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :show, :edit, :update ]
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

  def edit
  end

  def update
    if @contract.update(contract_params)
      redirect_to @consumer, notice: "Договор №#{@contract.number} успешно отредактирован"
    else
      flash[:alert] = 'Невозможно отредактировать договор'
      render :edit
    end
  end

  def show
    @counters = @contract.counters.all.order(:number)
    @counters_power={}
    @all_power_active, @all_power_reactive, @all_power_generation = 0, 0, 0
    @counters.each do |item|
      power = item.powers.where("measure_date >= ? AND measure_date <= ?",
                                DateTime.now.beginning_of_month.to_date,
                                DateTime.now.end_of_month.to_date).last
      prew_power = item.powers.where("measure_date >= ? AND measure_date <= ?",
                                DateTime.now.prev_month.beginning_of_month.to_date,
                                DateTime.now.prev_month.end_of_month.to_date).last
      prew_power ||= item.powers.new(measure_date: DateTime.now.prev_month)
      power ||= item.powers.new(measure_date: DateTime.now,
                                active: prew_power.active,
                                reactive: prew_power.reactive,
                                generation: prew_power.generation,
                                before_active: prew_power.active,
                                before_reactive: prew_power.reactive,
                                before_generation: prew_power.generation)
      @all_power_active += power.active_result * item.ratio
      @all_power_reactive += power.reactive_result * item.ratio
      @all_power_generation += power.generation_result * item.ratio
      @counters_power[item.id] = power
    end
    @counter = @contract.counters.new
    respond_to do |format|
      format.html { render :show }
      format.pdf do
        archive_data = params[:archive_data].blank? ? DateTime.now : DateTime.strptime(params[:archive_data], "%m/%Y")
        send_data @contract.pdf_report(archive_data).render,
                  filename: "#{@contract.number}_#{DateTime.now.strftime('%Y_%m')}_report.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
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
