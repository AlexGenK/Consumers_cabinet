class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :edit, :update, :destroy]

  def index
    @consumers=Consumer.order(:name)
  end

  private

  def set_consumer
    @author = Consumer.find(params[:id])
  end

  def consumer_params
    params.require(:author).permit(:name, :edrpou, :dog_eh_num, :dog_eh_date, :dog_hoe_num, :dog_hoe_date, 
                                    :onec_id, :report_date, :user_email, :manager_email)
  end

end
