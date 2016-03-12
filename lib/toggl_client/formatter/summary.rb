module TogglClient
  module Formatter
    class Summary < Base

      # TODO: make this working also for different grouping than default
      # TODO: rounding parameter
      # TODO: implement custom formatting
      # TODO: projects without names
      def billable_items
        data.each do |project_data|
          process_project(project_data)
        end

        billable
      end

      private

      def process_project(project_data)
        project = project_data['title']['project']
        client  = project_data['title']['client'] || NO_GROUP_KEY
        billable[client] = [] unless billable[client]

        project_data['items'].each do |item|
          billable[client] << {
            task: "#{project}: #{item['title']['time_entry']}",
            amount: item['time'].to_hours,
            unit: :hours
          }
        end
      end
    end
  end
end