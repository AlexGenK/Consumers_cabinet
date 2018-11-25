class CountersController < ApplicationController
  before_action :set_counter, only: [:destroy, :show, :edit, :update]
  before_action :set_consumer, only: [:create, :destroy, :edit, :update]
  before_action :detect_invalid_user
  rescue_from ActiveRecord::RecordNotFound, with: :denied_action
  load_and_authorize_resource

  def create
    @counter = @consumer.counters.new(counter_params)
    flash[:alert] = 'Невозможно создать счетчик' unless @counter.save
    redirect_to @consumer
  end

  def destroy
    flash[:alert] = 'Невозможно удалить счетчик' unless @counter.destroy
    redirect_to @consumer
  end

  def edit
  end

  def update
    if @counter.update(counter_params)
        redirect_to @consumer, notice: 'Счетчик успешно отредактирован'
      else
        flash[:alert] = 'Невозможно отредактировать счетчик'
        render :edit
      end
  end

  private

  def set_counter
    @counter = Counter.find(params[:id])
  end

  def set_consumer
    @consumer = Consumer.find(params[:consumer_id])
  end

  def counter_params
    params.require(:counter).permit(:number, :ratio, :account)
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
    redirect_to :consumers, alert: "Попытка доступа к не существующему или не принадлежащему Вам счетчику"
  end
end
