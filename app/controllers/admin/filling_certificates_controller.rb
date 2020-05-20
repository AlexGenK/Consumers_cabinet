class Admin::FillingCertificatesController < ApplicationController

  skip_before_action :verify_authenticity_token
  authorize_resource :class => false

  require 'net/ftp'
  require 'date'

  def start
    Net::FTP.open(ENV['CONSUMERS_CABINET_FTP_HOST'], 
                  ENV['CONSUMERS_CABINET_FTP_USERNAME'],
                  ENV['CONSUMERS_CABINET_FTP_PASSWORD'],) do |ftp|
      @files = ftp.nlst.map { |filename| parse_filename(filename) }
    end
  end

  private

  def parse_filename(filename)
    parse_result = {date: parse_date(filename), consumer_id: parse_id(filename)}
    return parse_result
  end

  def parse_date(filename)
    filename =~ /(\d\d\.\d\d\.\d\d)_\d+/
    DateTime.strptime($1, '%d.%m.%y')
  end

  def parse_id(filename)
    filename =~ /\d\d\.\d\d\.\d\d_(\d+)/
    $1
  end

end