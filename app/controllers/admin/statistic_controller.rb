class Admin::StatisticController < ApplicationController
  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  def consumers_counter
    @consumers_count = Consumer.group(:manager_username).order(:manager_username).count.delete_if { |key, value| key.blank? }
    @consumers_sum = @consumers_count.sum { |key, value| value }
  end
end
