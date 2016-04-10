module TogglBillable
  module Reports
    class Summary < Base
      def get_report(options)
        params[:since]       = options[:start_date]
        params[:until]       = options[:end_date]
        params[:grouping]    = options[:grouping] if options[:grouping]
        params[:subgrouping] = options[:subgrouping] if options[:grouping]

        request = "summary?#{hash_to_params}"
        @report = JSON.parse(Client.report_get(request).body)
      end
    end
  end
end