module TogglBillable
  module Formatter
    class Base
      attr_accessor :data, :billable

      NO_CLIENT_KEY = 'NO_CLIENT'

      def initialize(report, options = {})
        @data     = report['data']
        @billable = {}
        @no_client_key = options[:default_client] || NO_CLIENT_KEY
      end

    end
  end
end