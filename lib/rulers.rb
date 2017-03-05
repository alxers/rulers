require 'rulers/version'
require 'rulers/array'
require 'rulers/routing'

module Rulers
  class Application
    def call(env)
      stub_favicon(env)
      if env['PATH_INFO'] == '/'
        klass = Object.const_get 'HomeController'
        act = 'index'
      else
        klass, act = get_controller_and_action(env)
      end
      controller = klass.new(env)
      begin
        success_response(controller, act)
      rescue StandardError => e
        failure_response(e)
      end
    end

    private

    def stub_favicon(env)
      response = [404, { 'Content-Type' => 'text/html' }, []]
      return response unless env['PATH_INFO'] != '/favicon.ico'
    end

    def success_response(controller, act)
      text = controller.send(act)
      [200, { 'Content-Type' => 'text/html' }, [text]]
    end

    def failure_response
      [500, { 'Content-Type' => 'text/html' },
       ["Message error: #{e.message}"]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env
  end
end
