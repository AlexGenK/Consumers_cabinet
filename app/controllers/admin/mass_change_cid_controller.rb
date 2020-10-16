class Admin::MassChangeCidController < ApplicationController
  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  require 'csv'

  def set_params
  end

  def start
    begin
      csv_text = params[:datafile].read.encode('UTF-8', 'Windows-1251')
      csv = CSV.parse(csv_text)
      @log = []
      csv.each do |record|
        @consumer = Consumer.find_by(onec_id: record[0].to_i)
        if @consumer
          @consumer.onec_id = record[1].to_i
          @consumer.save!
          @log << "#{@consumer.name} #{record[0]} => #{record[1]}"
        end
      end
    rescue
      flash[:alert] = 'Ошибка при импорте записей из файла!'
      @imported = 0
    end
  end

  private

  def mass_change_cid_params
    params.require(mass_change_cid).permit(:datafile)
  end
end
