class BeforeAfterValidator < ActiveModel::Validator
  def validate(record)
    if record.active < record.before_active
      record.errors.add(:active, "Текущее значение активной мощности не может быть меньше предыдущего")
    end
    if record.reactive < record.before_reactive
      record.errors.add(:reactive, "Текущее значение реактивной мощности не может быть меньше предыдущего")
    end
    if record.generation < record.before_generation
      record.errors.add(:generation, "Текущее значение генерации не может быть меньше предыдущего")
    end
  end
end