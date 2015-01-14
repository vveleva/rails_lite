require 'webrick'
# require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase7/flash'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class FlashController < Phase7::ControllerBase
  def index
    flash[:errors] = ["Testing errors"]
    render :index
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  FlashController.new(req, res).index
end

trap('INT') { server.shutdown }
server.start
