require_relative '../phase6/controller_base'

module Phase7
  class ControllerBase < Phase6::ControllerBase

    def redirect_to(url)
      super(url)
      flash.store_flash(@res)
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
    def initialize(req)
      cookie = req.cookies.find { |c| c.name == '_rails_lite_app_flash' }

      @flash = FlashHash.new
      @flash_now = FlashHash.new

      JSON.parse(cookie.value).each { |k, v| @flash_now[k] = v } if cookie
    end

    def now
      @flash_now ||= FlashHash.new
    end

    def [](key)
      @flash_now[key] || @flash[key]
    end

    def []=(key, val)
      @flash[key] = val
    end

    def store_flash(res)
      cookie = WEBrick::Cookie.new( '_rails_lite_app_flash', @flash.to_json )

      res.cookies << cookie
    end
  end

  class FlashHash
    def initialize
      @flash = {}
    end

    def [](key)
      @flash[key.to_s]
    end

    def []=(key, val)
      @flash[key.to_s] = val
    end

    def to_json
      @flash.to_json
    end
  end

end
