class Admin::FillingConsumersController < ApplicationController

  def set_params
  end

  def start
    datafile = params[:datafile].open
    @filestring = datafile.readlines.map { |item| item.encode('UTF-8', 'Windows-1251') }
  end

  private

  def filling_consumers_params
    params.require(:filling_consumers).permit(:datafile)
  end
end
