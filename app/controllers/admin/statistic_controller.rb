class Admin::StatisticController < ApplicationController
  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  def consumers_counter
    
  end
end
