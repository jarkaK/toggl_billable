module TogglBillable
  module Reports
    class Details < Base
      def get_report(options = {})
        params[:since]       = options[:start_date]
        params[:until]       = options[:end_date]
        params[:grouping]    = options[:grouping] if options[:grouping]
        params[:subgrouping] = options[:subgrouping] if options[:grouping]
        params[:page]        = options[:page] || 1
        params[:order_field] = options[:oder_field] || 'date'
        count = 0

        result = {}

        loop do
          request = "details?user_agent=reports&#{hash_to_params}"
          response = JSON.parse(Client.report_get(request).body)

          if result.size == 0
            result = response
          else
            result['data'] += response['data']
          end

          count += response['data'].count
          break if count >= response['total_count']

          params[:page] += 1
        end

        result
      end
    end
  end
end