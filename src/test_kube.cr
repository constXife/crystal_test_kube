require "kemal"

get "/" do
  "Hello, TestKube!"
end

Kemal.run do |config|
  server = config.server.not_nil!
  server.bind_tcp "0.0.0.0", 3000, reuse_port: true
end
