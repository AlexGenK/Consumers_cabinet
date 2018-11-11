class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :edit, :update, :destroy]
  before_action :set_users_list, only: [:new, :edit, :create]
  before_action :detect_invalid_user, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :denied_action
  load_and_authorize_resource


  def index
    @consumers={}
    if current_user.admin_role?
      @consumers=Consumer.order(:name)
    elsif current_user.manager_role?
      @consumers=Consumer.where('manager_username = ?', current_user.username).order(:name)
    elsif current_user.client_role?
      @consumers=Consumer.where('client_username = ?', current_user.username).order(:name)
    end
  end

  def new
    @consumer = Consumer.new
    @consumer.manager_username = current_user.username
  end

  def show
    @prev_consumptions = @consumer.previous_consumptions.all.order('date DESC')
    @plan_consumption = @consumer.current_consumption
    @counters = @consumer.counters.all.order(:number)
    @counters_power={}
    @all_power_active, @all_power_reactive, @all_power_generation = 0, 0, 0
    @counters.each do |item|
      power = item.powers.where("measure_date >= ?", DateTime.now.beginning_of_month.to_date).last
      power ||= item.powers.new(measure_date: DateTime.now)
      @all_power_active += power.active_result * item.ratio
      @all_power_reactive += power.reactive_result * item.ratio
      @all_power_generation += power.generation_result * item.ratio
      @counters_power[item.id] = power
    end
    @counter = @consumer.counters.new
  end

  def create
    @consumer = Consumer.new(consumer_params)
    if @consumer.save
      redirect_to consumers_path, notice: "Потребитель #{@consumer.name} успешно создан"
    else
      flash[:alert] = 'Невозможно создать потребителя'
      render :new
    end
  end

  def destroy
    Consumer.find(params[:id]).destroy
    redirect_to consumers_path
  end

  def edit
  end

  def update
    if @consumer.update(consumer_params)
        redirect_to consumer_path(@consumer), notice: "Потребитель #{@consumer.name} успешно отредактирован"
      else
        flash[:alert] = 'Невозможно создать потребителя'
        render :edit
      end
  end

  private

  def set_consumer
    @consumer = Consumer.find(params[:id])
  end

  def set_users_list
    @managers = User.where("manager_role").collect(&:username)
    @clients = User.where("client_role").collect(&:username)
  end

  def consumer_params
    params.require(:consumer).permit(:name, :edrpou, :dog_eh_num, :dog_eh_date, :dog_hoe_num, :dog_hoe_date, 
                                    :onec_id, :report_date, :client_username, :manager_username, :full_name)
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
    redirect_to :consumers, alert: "Попытка доступа к не существующему или не принадлежащему Вам потребителю"
  end

end
