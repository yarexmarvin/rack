class TimeFormatter
  DATE_FORMATS = {
    "year" => "%Y",
    "month" => "%m",
    "day" => "%d",
    "hour" => "%H",
    "minute" => "%M",
    "second" => "%S",
  }.freeze

  def initialize(formats)
    @date_formats = formats.split(",")
    @wrong_formats = []
    @result_formats = []
  end

  def call
    @date_formats.each do |format|
      if DATE_FORMATS[format]
        @result_formats << DATE_FORMATS[format]
      else
        @wrong_formats << format
      end
    end
  end

  def successful?
    @wrong_formats.empty?
  end

  def result
    Time.now.strftime(@result_formats.join("-"))
  end

  def invalid_result
    "Unknown time format #{@wrong_formats}" unless successful?
  end
end
