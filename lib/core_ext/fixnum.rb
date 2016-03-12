class Fixnum
  DEFAULT_ROUNDING = 0.25

  def to_hours(round=nil)
    round ||= DEFAULT_ROUNDING

    ((self / 3600000.0) / round).round  * 0.25
  end
end