class ThisIsIbanValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
  	unless length_correct?(value) && mod97_correct?(value)
  		record.errors[attribute] << "is not an IBAN"
  	end
  	true
  end

  protected

  def length_correct?(value)
  	value.size == 29
  end

  def mod97_correct?(value)
  	iban_verify = value.dup
  	iban_verify += iban_verify.slice!(0..3)
  	iban_verify.gsub!(/[A-Z]/) {|item| item.ord-55}
  	(iban_verify.to_i % 97) == 1
  end

end