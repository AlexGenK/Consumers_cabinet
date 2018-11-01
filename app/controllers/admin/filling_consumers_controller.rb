class Admin::FillingConsumersController < ApplicationController
  require 'csv'

  def set_params
  end

  def start
    csv_text = params[:datafile].read.encode('UTF-8', 'Windows-1251')
    csv_text.gsub!(/"/,'\'')
    @csv = CSV.parse(csv_text, col_sep: ';')
  end

  private

  def filling_consumers_params
    params.require(:filling_consumers).permit(:datafile)
  end
end
