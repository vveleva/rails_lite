require_relative '../phase6/router'
require_relative './url_helpers'
require 'byebug'

module Phase8
  class Route < Phase6::Route

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern = pattern
      @http_method = http_method
      @controller_class = controller_class
      @action_name = action_name

      add_url_helpers
    end

    def add_url_helpers
      case action_name
      when :index || :create
        name = controller_subject
        add_method "#{name}_url", proc { "/#{name}" }

      when :edit
        name = controller_subject
        add_method "edit_#{name.singularize}_url",
                    proc { |id|"/#{name}/#{id}/edit" }

      when :show || :update || :destroy
        name = controller_subject.singularize
        add_method "#{name}_url", proc { |id| "/#{name}/#{id}" }

      when :new
        name = controller_subject
        add_method "new_#{name.singularize}_url",
                    proc { |id| "/#{name}/#{id}/new" }
      end
    end

    def controller_subject
      controller_class.name.underscore.split('_').first
    end

    def add_method name, body
      controller_class.send(:define_method, name, &body)
    end
  end

  class Router < Phase6::Router
    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end
  end
end
