module TogglBillable
  module Reports
    class Base
      attr_accessor :params, :report, :options

      def initialize(options = {})
        @params = {
          workspace_id: options[:workspace_id] || User.new.default_workspace_id,
          user_agent: options[:user_agent] || 'toggl_client'
        }
        @options = options
      end

      def last_month_billable
        start = DateTime.now.prev_month

        start_date = start.strftime('%Y-%m-01')
        end_date   = DateTime.civil(start.year, start.month, -1).strftime(('%Y-%m-%d'))

        @report ||= get_report(start_date: start_date, end_date: end_date)
        billable_items
      end

      private

      def billable_items
        params = {}
        params[:default_client] = options[:default_client] if options[:default_client]

        klass = Object.const_get("TogglBillable::Formatter::#{self.class.to_s.gsub(/^.*::/, '')}")
        klass.new(report, options).billable_items
      end

      def hash_to_params
        return '' unless params

        params.map{ |k, v| "#{k}=#{v}" }.join('&')
      end
    end
  end
end