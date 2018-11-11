class PowersController < ApplicationController
  before_action :set_power, only: [:destroy, :edit, :update]
  before_action :set_counter, only: [:create, :destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :edit, :update]
  before_action :detect_invalid_user
  load_and_authorize_resource

  def create
    @power = @counter.powers.new(power_params)
    if @power.save
      @consumer.send_power_to_current
    else
      flash[:alert] = 'Невозможно передать показания счетчика'
    end
    redirect_to @consumer
  end

  def update
    if @power.update(power_params)
        @consumer.send_power_to_current
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

  def detect_invalid_user
    unless current_user.admin_role?
      if current_user.manager_role?
        denied_action if @consumer.manager_username != current_user.username
      elsif current_user.client_role?
        denied_action if @consumer.client_username != current_user.username
      end
    end
  end

  def denied_action
    redirect_to :consumers, alert: "Попытка доступа к показаниям не существующего или не принадлежащего Вам счетчика"
  end
end
