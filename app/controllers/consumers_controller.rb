class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :edit, :update, :destroy]

  def index
    @consumers=Consumer.order(:name)
  end

  def new
    @consumer = Consumer.new
  end

  def show
    @prev_consumptions = @consumer.previous_consumptions.all.order('date DESC')
    @counters = @consumer.counters.all.order(:number)
    @counters_power={}
    @counters.each do |item|
      power = item.powers.where("measure_date >= ?", DateTime.now.beginning_of_month.to_date).last
      power ||= item.powers.new(measure_date: DateTime.now)
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
        redirect_to consumers_path, notice: "Потребитель #{@consumer.name} успешно отредактирован"
      else
        flash[:alert] = 'Невозможно создать потребителя'
        render :edit
      end
  end

  private

  def set_consumer
    @consumer = Consumer.find(params[:id])
  end

  def consumer_params
    params.require(:consumer).permit(:name, :edrpou, :dog_eh_num, :dog_eh_date, :dog_hoe_num, :dog_hoe_date, 
                                    :onec_id, :report_date, :user_email, :manager_email)
  end

end
