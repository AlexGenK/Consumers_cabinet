class Admin::FillingConsumptionsController < ApplicationController

  skip_before_action :verify_authenticity_token
  authorize_resource :class => false
  
  require 'csv'

  def set_params
  end

  def start
    begin
      csv_text = params[:datafile].read.encode('UTF-8', 'Windows-1251').gsub(/"/,'\'')
      csv = CSV.parse(csv_text, col_sep: ';')
      @imported = 0
      PreviousConsumption.delete_all
      csv.each do |record|
        @consumer = Consumer.find_by(onec_id: record[0].to_i)
        if @consumer && (record[2].to_i > 0)
          @consumer.previous_consumptions.new(date: Date.strptime(record[1], '%d.%m.%y'),
                                              power: record[2].to_i,
                                              tariff: record[3].to_f,
                                              money: record[4].to_f).save
          @imported += 1
        end
      end
    rescue
      flash[:alert] = 'Ошибка при импорте записей из файла!'
      @imported = 0
    end
  end

  private

  def filling_consumptions_params
    params.require(:filling_consumptions).permit(:datafile)
  end
end
