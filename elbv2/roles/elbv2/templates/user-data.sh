#!/bin/sh

# Standalone server
#
ruby -e 'require "webrick"

class Echo < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, name)
    super server
    @name = name
  end
  def do_GET(request, response)
    response.status = 200
    response.body = @name + ": " + request.path.to_s + "\n"
  end
end

server = WEBrick::HTTPServer.new()
server.mount "/", Echo, "{{ item.name }}"
trap "INT" do server.shutdown end
server.start
puts "Echo Server Started" ' &
