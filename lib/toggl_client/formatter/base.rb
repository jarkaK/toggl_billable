module TogglClient
  module Formatter
    class Base
      attr_accessor :data, :billable

      NO_GROUP_KEY = 'NO_GROUP'

      def initialize(report)
        @data     = report['data']
        @billable = {}
      end

    end
  end
end