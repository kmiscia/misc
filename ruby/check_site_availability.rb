require 'net/http'
require 'net/smtp'
require 'date'

class SiteAvailability

  EMAIL_FROM = "system@miscia.net"
  EMAIL_TO = "kmiscia@gmail.com"
  EMAIL_USERNAME = "kmiscia@miscia.net"
  EMAIL_PASSWORD = "" #TODO
  EMAIL_DOMAIN = "miscia.net"
  EMAIL_SMTP_SERVER = "smtp.gmail.com"
  EMAIL_SMTP_PORT = 587

  attr_accessor :host

  def initialize(params)
    @host = params[:host] if params[:host]
  end

  def check
    begin
      case Net::HTTP.get_response(URI(@host))
        when Net::HTTPSuccess
          send_email_success
        else
          send_email_failure
      end
    rescue StandardError => e
      p e.message
      #TODO - How to handle failture?
    end
  end

  private

  def send_email_success
    subject = "SUCCESS: #{@host} is available"
    message = "Site availability check @ #{Date.today.to_s} - #{Time.now} succeeded."
    send_email( subject, message)
  end

  def send_email_failure
    subject = "CRITICAL: #{@host} is unavailable"
    message = "Site availability check @ #{Date.today.to_s} - #{Time.now.to_s} failed."
    send_email( subject, message)
  end

  def send_email(subject, message)

    msg = <<END_OF_MESSAGE
  From: <#{EMAIL_FROM}>
  To: <#{EMAIL_TO}>
  Subject: #{subject}
  #{message}
END_OF_MESSAGE

    smtp = Net::SMTP.new(EMAIL_SMTP_SERVER, EMAIL_SMTP_PORT)
    smtp.enable_starttls
    p "sending to #{EMAIL_TO}"
    smtp.start( EMAIL_DOMAIN, EMAIL_USERNAME, EMAIL_PASSWORD, :plain) do |smtp|
      p smtp.send_message(msg, EMAIL_FROM, EMAIL_TO)
    end
  end
end

SiteAvailability.new({:host => "http://www.miscia.net/"}).check