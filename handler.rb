require "/Users/yarexmarvin/.rvm/rubies/ruby-3.1.2/bin/rake.rb"

app = Proc.new do |env|
  [
    200,
    { "Content-Type" => "text/plain" },
    ["Welcome aboard!\n"],
  ]
end

Rack::Handler::WEBrick.run app
