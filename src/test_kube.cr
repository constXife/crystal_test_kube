require "kemal"

get "/" do
  "Hello, TestKube!"
end

http_port = ENV.fetch("HTTP_PORT", "3000").to_i

Kemal.run do |config|
  server = config.server.not_nil!
  server.bind_tcp "0.0.0.0", http_port, reuse_port: true
end
