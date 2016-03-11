module TogglClient
  module Reports
    class Summary
      attr_accessor :params, :report

      def initialize(options = {})
        @params = {
          workspace_id: options[:workspace_id] || User.new.default_workspace_id,
          user_agent: options[:user_agent] || 'toggl_client'
        }
      end

      def get_report(start_date, end_date)
        params[:since] = start_date
        params[:until] = end_date

        request = "summary?#{hash_to_params(params)}"
        @report = JSON.parse(Client.report_get(request).body)
      end

      def billable_items
        TogglClient::Formatter::Summary.new(report).billable_items
      end

      def last_month_to_bill
        @report ||= report(nil, nil)
        billable_items
      end

      private

      def hash_to_params(params)
        return '' unless params

        params.map{ |k, v| "#{k}=#{v}" }.join('&')
      end
    end
  end
end