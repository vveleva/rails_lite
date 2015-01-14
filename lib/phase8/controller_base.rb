require_relative '../phase7/flash'
require_relative './router'
require_relative './url_helpers'

module Phase8
  class ControllerBase < Phase7::ControllerBase
    include URLHelpers
  end
end
