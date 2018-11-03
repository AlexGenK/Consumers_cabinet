class Admin::FillingPlanController < ApplicationController
  require 'csv'

  def set_params
  end

  def start
    begin
      csv_text = params[:datafile].read.encode('UTF-8', 'Windows-1251').gsub(/"/,'\'')
      csv = CSV.parse(csv_text, col_sep: ';')
      @imported = []
      CurrentConsumption.delete_all
      csv.each do |record|
        @consumer = Consumer.find_by(onec_id: record[0].to_i)
        if @consumer
          @cur_pow = @consumer.build_current_consumption(power: record[1].to_i,
                                                        tariff: record[2].to_f,
                                                        money: record[3].to_f)
          @cur_pow.save
          @imported << [@consumer.name, @cur_pow.power, @cur_pow.tariff, @cur_pow.money]
        end
      end
    rescue
      @imported = []
      flash[:alert] = 'Ошибка при импорте записей из файла!'
    end
  end

  private

  def filling_plan_params
    params.require(:filling_plan).permit(:datafile)
  end
end
