class Admin::FillingCertificatesController < ApplicationController

  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  def set_params
  end

  def start

  end

  private

  def filling_certificates_params
    params.require(:filling_certificates).permit(:datadir)
  end
end