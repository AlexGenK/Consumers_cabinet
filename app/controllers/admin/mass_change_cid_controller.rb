class Admin::MassChangeCidController < ApplicationController
  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  require 'csv'

  def set_params
  end

  def start
  end

  private

  def mass_change_cid_params
    params.require(mass_change_cid).permit(:datafile)
  end
end
