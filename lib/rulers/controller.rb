require 'erubis'

module Rulers
  class Controller
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
      @user_agent = env['HTTP_USER_AGENT']
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name,
                           "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def controller_name
      klass = self.class.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end
  end
end
