module TogglBillable
  module Formatter
    class Details < Base
      SKIP_GROUP_DATES = []
      SHORT_DATES = [nil]

      # TODO: make this working also for different grouping than default
      def billable_items(with_dates = true)
        group = data.group_by { |d| d['client'] }

        group.each do |group_name, group_items|
          key = group_name || @no_client_key
          billable[key] = [] unless billable[key]
          subgroup = group_items.group_by { |d| d['project'] }

          subgroup.each do |subgroup_name, subgroup_items|
            subgroup_items.group_by { |d| d['description'] }.each do |item, data|
              if with_dates && !SKIP_GROUP_DATES.include?(subgroup_name)
                task = "#{dates(data, SHORT_DATES.include?(subgroup_name))}: "
              else
                task = ''
              end

              if item && subgroup_name
                task += "#{subgroup_name}: #{item}"
              elsif item
                task += "#{item}"
              elsif subgroup_name
                task += "#{subgroup_name}"
              end

              billable[key] << {
                task: task,
                amount: data.map {|i| i['dur']}.reduce(0, :+).to_hours,
                unit: :hours
              }
            end
          end
        end

        billable
      end

      private

      def dates(items, short)
        start_date = Date.parse(items.sort_by { |i| i['start'] }.first['start'])
        end_date   = Date.parse(items.sort_by { |i| i['end'] }.reverse.first['end'])

        return start_date.strftime(TogglBillable::Config.format_month).to_s if short

        if start_date.strftime('%-d') == end_date.strftime('%-d')
          start_date.strftime(TogglBillable::Config.format_day)
        else
          start_date = start_date.strftime(TogglBillable::Config.format_daterange_start)
          end_date = end_date.strftime(TogglBillable::Config.format_daterange_end)

          "#{start_date}-#{end_date}"
        end
      end
    end
  end
end