class Admin::FillingConsumersController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  require 'csv'

  def set_params
  end

  def start
    begin
      csv_text = params[:datafile].read.encode('UTF-8', 'Windows-1251').gsub(/"/,'\'')
      csv = CSV.parse(csv_text, col_sep: ';')
      @imported = []
      csv.each do |record|
        unless Consumer.exists?(onec_id: record[0].to_i)
          Consumer.new(name: record[1],
                      full_name: record[2],
                      edrpou: record[3],
                      dog_eh_num: record[4],
                      dog_eh_date: Date.strptime(record[5], '%d.%m.%y'),
                      onec_id: record[0].to_i).save
          @imported << record
        end
      end
    rescue
      flash[:alert] = 'Ошибка при импорте записей из файла!'
      @imported = []
    end
  end

  private

  def filling_consumers_params
    params.require(:filling_consumers).permit(:datafile)
  end
end
