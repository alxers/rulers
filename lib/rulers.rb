require 'rulers/version'
require 'rulers/array'
require 'rulers/routing'

module Rulers
  class Application
    def call(env)
      `echo debug > debug.txt`
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { 'Content-Type' => 'text/html' }, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env
  end
end
