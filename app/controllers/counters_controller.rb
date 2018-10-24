class CountersController < ApplicationController
  before_action :set_counter, only: [:destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :edit, :update]

  def create
    @counter = @consumer.counters.new(counter_params)
    flash[:alert] = 'Невозможно создать счетчик' unless @counter.save
    redirect_to @consumer
  end

  def destroy
    flash[:alert] = 'Невозможно удалить счетчик' unless @counter.destroy
    redirect_to @consumer
  end

  private

  def set_counter
    @counter = Counter.find(params[:id])
  end

  def set_consumer
    @consumer = Consumer.find(params[:consumer_id])
  end

  def counter_params
    params.require(:counter).permit(:number, :ratio)
  end
end
