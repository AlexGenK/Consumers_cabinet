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
      pdf.font_size 8
      @counters = counters.all.order(:number)
      @all_power_active, @all_power_reactive, @all_power_generation = 0, 0, 0
      @table = []
      @table << ['', '', 'Наст.', 'Пред.', 'Разность', 'Расход']
      @counters.each do |item|
        power = item.powers.where("measure_date >= ? AND measure_date <= ?",
                                rep_date.beginning_of_month.to_date,
                                rep_date.end_of_month.to_date).last
        if power
          @table << ["Счетчик №#{item.number}, КУ=#{item.ratio}", 'Активная', "#{power.active}", "#{power.before_active}", "#{power.active_result}", "#{power.active_result * item.ratio}"]
          @table << ['', 'Реактивная', "#{power.reactive}", "#{power.before_reactive}", "#{power.reactive_result}", "#{power.reactive_result * item.ratio}"]
          @table << ['', 'Генерация', "#{power.generation}", "#{power.before_generation}", "#{power.generation_result}", "#{power.generation_result * item.ratio}"]

          @all_power_active += power.active_result * item.ratio
          @all_power_reactive += power.reactive_result * item.ratio
          @all_power_generation += power.generation_result * item.ratio
        end
      end
      pdf.table(@table) do |t|
          t.cells.border_width = 1
      end
      pdf.move_down 20

      @table = []
      @table << [{content: "Всего", colspan: 2}]
      @table << ['Активная', "#{@all_power_active}"]
      @table << ['Реактивная', "#{@all_power_reactive}"]
      @table << ['Генерация', "#{@all_power_generation}"]
      pdf.table(@table) do |t|
          t.cells.border_width = 1
      end

      pdf.move_down 40
      pdf.font_size 7
      pdf.text DateTime.now.strftime('Сгенерировано %F в %T')
      return pdf
  end
end
