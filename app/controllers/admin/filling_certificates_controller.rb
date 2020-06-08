class Admin::FillingCertificatesController < ApplicationController

  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  require 'net/ftp'
  require 'date'

  def start
    @add_certs = []
    @cons_with_cert = Consumer.where(can_get_certificate: true)
    @cert_list = get_newest_certs
    @cons_with_cert.each do |consumer|
      if @cert_list[consumer.edrpou]
        @cert = consumer.build_certificate(date: @cert_list[consumer.edrpou][:date])
        @cert.save!
        Net::FTP.open(ENV['CONSUMERS_CABINET_FTP_HOST'], 
                  ENV['CONSUMERS_CABINET_FTP_USERNAME'],
                  ENV['CONSUMERS_CABINET_FTP_PASSWORD'],) do |ftp| 
          ftp.getbinaryfile(@cert_list[consumer.edrpou][:filename], 'public/akt.xls')
        end
        @cert.print_form.attach(io: File.open('public/akt.xls'), filename: 'akt.xls', content_type: 'application/vnd.ms-excel')
        @add_certs << "Потребитель #{consumer.name} (#{consumer.edrpou}) - акт от #{@cert_list[consumer.edrpou][:date]}"
      end
    end
  end

  private

  def get_newest_certs
    files = {}
    Net::FTP.open(ENV['CONSUMERS_CABINET_FTP_HOST'], 
                  ENV['CONSUMERS_CABINET_FTP_USERNAME'],
                  ENV['CONSUMERS_CABINET_FTP_PASSWORD'],) do |ftp| 
      ftp.nlst.each do |filename|
        if !files[parse_id(filename)] || files[parse_id(filename)][:date] < parse_date(filename)
          files[parse_id(filename)] = {date: parse_date(filename), filename: filename}
        end
      end
    end
    return files
  end

  def parse_date(filename)
    filename =~ /(\d\d\.\d\d\.\d\d)_\d*/
    DateTime.strptime($1, '%d.%m.%y')
  end

  def parse_id(filename)
    filename =~ /\d\d\.\d\d\.\d\d_(\d+)/
    $1
  end

end