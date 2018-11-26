class Contract < ApplicationRecord
  has_many :counters, dependent: :destroy
  belongs_to :consumer

  def pdf_report(rep_date)
      pdf = Prawn::Document.new
      pdf.font Rails.root.join("app/assets/fonts/arial.ttf")
      pdf.text consumer.full_name
      pdf.move_down 20
      pdf.text "Отчет за #{I18n.l(rep_date, format: '%B %Y')} по дог. №#{number}"
      pdf.move_down 20
      @counters = counters.all.order(:number)
      @table = []
      @counters.each do |item|
        power = item.powers.where("measure_date >= ? AND measure_date <= ?",
                                rep_date.beginning_of_month.to_date,
                                rep_date.end_of_month.to_date).last
        if power
          @table << ['', '', 'Наст.', 'Пред.', 'Разность', 'Расход']
          @table << ["Счетчик №#{item.number}", 'Активная', "#{power.active}", "#{power.before_active}", '', '']
          @table << ['', 'Реактивная', "#{power.reactive}", "#{power.before_reactive}", '', '']
          @table << ['', 'Генерация', "#{power.generation}", "#{power.before_generation}", '', '']
          @table << ['', '', '', '', '', '']
        end
      end
      pdf.table(@table)
      return pdf
  end
end
