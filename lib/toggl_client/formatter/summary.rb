module TogglClient
  module Formatter
    class Summary
      attr_reader :data, :billable
      NO_CLIENT_KEY = 'NO_CLIENT'

      def initialize(report)
        @data     = report['data']
        @billable = {}
      end

      def billable_items
        data.each do |project_data|
          process_project(project_data)
        end

        billable
      end

      private

      def process_project(project_data)
        project = project_data['title']['project']
        client  = project_data['title']['client'] || NO_CLIENT_KEY
        billable[client] = [] unless billable[client]

        project_data['items'].each do |item|
          billable[client] << {
            task: "#{project}: #{item['title']['time_entry']}",
            amount: item['time'].to_hour,
            unit: :hours
          }
        end
      end
    end
  end
end