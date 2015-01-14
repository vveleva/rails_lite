require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      self.send(name)
    end

    def render_content(content, type)
      super(content, type)
      flash.store_flash(@res)
    end

    def flash
      @flash ||= Flash.new(@req)
    end
  end

  class Flash
    def initialize
      @hash = {}
    end

    def [](key)
      @hash[key]
    end

    def []=(key, val)
      @hash[key] = val
    end

    def store_flash(res)
      cookie = WEBrick::Cookie.new( '_rails_lite_app_flash', @hash.to_json )

      cook.path = "/"
      res.cookies << cookie
    end
  end

end
