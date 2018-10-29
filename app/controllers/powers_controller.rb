class PowersController < ApplicationController
  before_action :set_power, only: [:destroy, :edit, :update]
  before_action :set_counter, only: [:create, :destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :edit, :update]

  def create
    @power = @counter.powers.new(power_params)
    flash[:alert] = 'Невозможно передать показания счетчика' unless @power.save
    redirect_to @consumer
  end

  def update
    if @power.update(power_params)
        redirect_to @consumer, notice: 'Показания успешно переданы'
      else
        redirect_to @consumer, alert: 'Невозможно передать показания'
      end
  end

  private

  def set_consumer
    @consumer = Consumer.find(params[:consumer_id])
  end

  def set_counter
    @counter = Counter.find(params[:counter_id])
  end

  def set_power
    @power = Power.find(params[:id])
  end

  def power_params
    params.require(:power).permit(:measure_date, :active, :reactive, :generation,
                                  :before_active, :before_reactive, :before_generation)
  end


end
