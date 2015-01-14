require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      @res['Location'] = url

      session.store_session(@res)
    end

    def render_content(content, type)
      @res.body = content
      @res.content_type = type

      session.store_session(@res)
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(@req)
    end
  end
end
