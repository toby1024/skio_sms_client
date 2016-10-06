module SkioSmsClient
  class SmsSender
    delegate :app_name, :send_key, :send_server, to: :configuration

    def self.send_sms(phone, message, message_type)
      sms_sender = SmsSender.new
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'
      page = agent.post(sms_sender.send_server, get_send_params(sms_sender.app_name, sms_sender.send_key, phone, message, message_type))
      htmlStr = page.body.to_s
      html_doc = Nokogiri::HTML(htmlStr)
      JSON.parse(html_doc)
    end

    private
    def configuration
      SkioSmsClient.configuration
    end

    def self.get_send_params(app_name, send_key, phone, message, message_type=nil)
      message_type ||= 'notice'
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      sign = Digest::MD5.hexdigest("#{send_key}#{timestamp}")
      {
          :phone => "#{phone}",
          :content => "#{message}",
          :sign => sign,
          :app_name => app_name,
          :timestamp => timestamp,
          :message_type => message_type
      }
    end
  end
end