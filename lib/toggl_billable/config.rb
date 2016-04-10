module TogglBillable
  class Config
    @format_daterange_start = '%b %-d'
    @format_daterange_end = '%-d'
    @format_day = '%b %-d'
    @format_month = '%b'

    class << self
      attr_accessor :format_daterange_start
      attr_accessor :format_daterange_end
      attr_accessor :format_day
      attr_accessor :format_month
    end

  end
end