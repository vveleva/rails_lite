require 'webrick'
require_relative '../lib/phase8/controller_base'
require_relative '../lib/phase8/router'


class FlashController < Phase7::ControllerBase

  def index
    flash[:errors] = ["Testing errors"]
    render :index
  end
end

router = Phase8::Router.new
router.draw do
  get Regexp.new("/"), FlashController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
