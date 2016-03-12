module TogglClient
  module Formatter
    class Summary < Base

      # TODO: make this working also for different grouping than default
      # TODO: rounding parameter
      # TODO: implement custom formatting
      # TODO: projects without names
      def billable_items
        data.group_by { |d| d['title']['client'] }.each do |group_name, group_data|
          key = group_name || NO_GROUP_KEY
          billable[key] = []
          group_data.group_by { |d| d['title']['project'] }.each do |subgroup_name, subgroup_data|
            process_project(subgroup_data.first)
          end
        end

        billable
      end

      private

      def process_project(project_data)
        project = project_data['title']['project']
        client  = project_data['title']['client'] || NO_GROUP_KEY

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