require_relative "time_formatter"

class App
  NOT_FOUND_ERROR = "404 Page not Found"

  def call(env)
    @env = env
    if @env["REQUEST_METHOD"] == "GET" && @env["REQUEST_PATH"] == "/time"
      handle_format_time_request
    else
      send_response(NOT_FOUND_ERROR, 404)
    end
  end

  private

  def handle_format_time_request
    time_formats = find_time_formats
    p time_formats
    time_formatter = TimeFormatter.new(time_formats)
    time_formatter.call

    if time_formatter.successful?
      send_response(time_formatter.result, 200)
    else
      send_response(time_formatter.invalid_result, 400)
    end
  end

  def find_time_formats
    Rack::Utils.parse_nested_query(@env["QUERY_STRING"])["format"]
  end

  def send_response(body, status)
    Rack::Response.new(body, status, headers).finish
  end

  def headers
    { "Content-Type" => "text/plain" }
  end
end
