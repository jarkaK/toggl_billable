module TogglClient
  class Client
    def self.start(api_token)
      @connection = Faraday.new(url: 'https://www.toggle.com') do |faraday|
        faraday.use Faraday::Request::BasicAuthentication, api_token, 'api_token'
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def self.api_base
      'https://www.toggl.com/api/v8'
    end

    def self.reports_base
      'https://toggl.com/reports/api/v2/'
    end

    def self.connection
      @connection
    end

    def self.api_get(end_point)
      connection.get("#{api_base}/#{end_point}")
    end

    def self.report_get(end_point)
      connection.get("#{reports_base}/#{end_point}")
    end

  end
end